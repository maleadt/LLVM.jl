// C++ counterpart of sum.jl

#include <string>
#include <vector>

#include <llvm/ExecutionEngine/ExecutionEngine.h>
#include <llvm/ExecutionEngine/GenericValue.h>
#include <llvm/ExecutionEngine/Interpreter.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Verifier.h>

static llvm::LLVMContext context;

int main(int argc, char *argv[]) {
  std::unique_ptr<llvm::Module> mod =
      llvm::make_unique<llvm::Module>("module", context);

  auto T_int32 = llvm::IntegerType::get(context, 32);
  auto fun_type = llvm::FunctionType::get(T_int32, {T_int32, T_int32}, false);
  auto sum = llvm::Function::Create(fun_type, llvm::Function::ExternalLinkage,
                                    "sum", mod.get());

  // generate IR
  llvm::IRBuilder<> builder(context);
  {
    auto *entry = llvm::BasicBlock::Create(context, "entry", sum);
    builder.SetInsertPoint(entry);

    auto args = sum->arg_begin();
    llvm::Value *arg1 = &(*args);
    args = std::next(args);
    llvm::Value *arg2 = &(*args);
    auto *tmp = builder.CreateAdd(arg1, arg2, "tmp");
    builder.CreateRet(tmp);

    mod->dump();
    verifyFunction(*sum);
  }

  // execute
  auto engine = llvm::EngineBuilder(std::move(mod))
                    .setEngineKind(llvm::EngineKind::Interpreter)
                    .create();
  {
    std::vector<llvm::GenericValue> args(2);
    args[0].IntVal = llvm::APInt(32, 1, /*isSigned=*/true);
    args[1].IntVal = llvm::APInt(32, 2, /*isSigned=*/true);

    auto res = engine->runFunction(sum, args);
    res.IntVal.dump();
  }

  return 0;
}
