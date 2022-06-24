#include "llvm/ADT/APFloat.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/raw_ostream.h"
#include "KaleidoscopeJIT.h"
#include <algorithm>
#include <cassert>
#include <cctype>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <map>
#include <memory>
#include <string>
#include <utility>
#include <vector>
#include <iostream>

#include "vm.h"

using namespace llvm;
using namespace llvm::orc;

// static std::unique_ptr<KaleidoscopeJIT> JIT;
// static std::unique_ptr<LLVMContext> TheContext;
// static std::unique_ptr<IRBuilder<>> Builder;
// static std::unique_ptr<Module> TheModule;
// static std::map<std::string, AllocaInst *> NamedValues;
static ExitOnError ExitOnErr;

// static void InitializeModule() {
//   // Open a new context and module.
//   TheContext = std::make_unique<LLVMContext>();
//   TheModule = std::make_unique<Module>("my cool jit", *TheContext);
//   TheModule->setDataLayout(TheJIT->getDataLayout());

//   // Create a new builder for the module.
//   Builder = std::make_unique<IRBuilder<>>(*TheContext);
// }

int main(int argc, char **argv) {
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();
  InitializeNativeTargetAsmParser();
  auto jit = ExitOnErr(KaleidoscopeJIT::Create());

  Type* structType = nullptr;
  Function* addFunction = nullptr;
  Function* pushConstFunction = nullptr;

  auto context = std::make_unique<LLVMContext>();
  SMDiagnostic err;
  auto vmModule = parseIRFile("vm.ll", err, *context);
  if (!vmModule) {
    err.print(argv[0], errs());
    return 1;
  }

  structType = StructType::getTypeByName(*context, "struct.State");
  if (structType == nullptr) {
    errs() << "struct.State was not found in vm.ll module\n";
    return 1;
  }

  addFunction = vmModule->getFunction("_Z3addP5State");
  if (addFunction == nullptr) {
    errs() << "_Z3addP5State was not found in vm.ll module\n";
    return 1;
  }

  pushConstFunction = vmModule->getFunction("_Z9pushConstP5Stateh");
  if (pushConstFunction == nullptr) {
    errs() << "_Z9pushConstP5Stateh was not found in vm.ll module\n";
    return 1;
  }

  {
    auto builder = std::make_unique<IRBuilder<>>(*context);

    std::vector<Type*> arguments;
    arguments.push_back(structType->getPointerTo());

    FunctionType* functionType = FunctionType::get(
      Type::getVoidTy(*context) /* Return type */,
      arguments,
      false /* is var arg */
    );

    Function* function = Function::Create(
      functionType,
      Function::ExternalLinkage,
      "__anon_expr",
      vmModule.get()
    );
    auto& stateArg = *function->args().begin();
    stateArg.setName("state");

    auto block = BasicBlock::Create(*context, "entry", function);
    builder->SetInsertPoint(block);

    IRBuilder<> TmpB(&function->getEntryBlock(), function->getEntryBlock().begin());
    AllocaInst* stateAlloca = TmpB.CreateAlloca(structType->getPointerTo(), nullptr, stateArg.getName());
    builder->CreateStore(&stateArg, stateAlloca);
    Value* stateAllocaValue = stateAlloca;

    {
      {
        std::vector<Value*> argumentValues;
        argumentValues.push_back(builder->CreateLoad(stateAllocaValue, stateArg.getName()));
        argumentValues.push_back(ConstantInt::get(
          IntegerType::get(*context, 8),
          1 /* value */,
          false /* isSigned */
        ));

        builder->CreateCall(pushConstFunction, argumentValues, "calltmp1");
      }

      {
        std::vector<Value*> argumentValues;
        argumentValues.push_back(builder->CreateLoad(stateAllocaValue, stateArg.getName()));
        argumentValues.push_back(ConstantInt::get(
          IntegerType::get(*context, 8),
          2 /* value */,
          false /* isSigned */
        ));

        builder->CreateCall(pushConstFunction, argumentValues, "calltmp2");
      }

      {
        std::vector<Value*> argumentValues;
        argumentValues.push_back(builder->CreateLoad(stateAllocaValue, stateArg.getName()));

        builder->CreateCall(addFunction, argumentValues, "calltmp3");
      }
    }

    builder->CreateRet(nullptr);

    verifyFunction(*function);
  }

  errs() << "Code was compiled into module.\n";
  errs() << "Functions defined in the module:\n";
  for (const auto& f : vmModule->getFunctionList()) {
    errs() << " - " << f.getName().str() << "\n";
  }
  // errs() << "Compiled module:\n";
  // errs() << *vmModule;

  auto tsm = ThreadSafeModule(std::move(vmModule), std::move(context));
  ExitOnErr(jit->addModule(std::move(tsm)));

  errs() << "Module was JIT'd.\n";
  errs() << "Execution state:\n";
  jit->ES->dump(errs());

  {
    State state;

    auto symbol = ExitOnErr(jit->lookup("__anon_expr"));
    auto *fp = (void (*)(State*))(intptr_t)symbol.getAddress();
    fp(&state);

    std::cout << int(state.stack[0]) << std::endl;
  }

  return 0;
}
