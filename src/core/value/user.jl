## user values (<: llvm::User)

abstract type User <: Value end

# operand iteration

export operands

struct UserOperandSet
    user::User
end

operands(user::User) = UserOperandSet(user)

Base.eltype(::UserOperandSet) = Value

Base.getindex(iter::UserOperandSet, i) =
    Value(API.LLVMGetOperand(ref(iter.user), Cuint(i-1)))

Base.setindex!(iter::UserOperandSet, val::Value, i) =
    API.LLVMSetOperand(ref(iter.user), Cuint(i-1), ref(val))

function Base.iterate(iter::UserOperandSet, i=1)
    i >= length(iter) + 1 ? nothing : (iter[i], i+1)
end

Base.length(iter::UserOperandSet) = API.LLVMGetNumOperands(ref(iter.user))

Base.lastindex(iter::UserOperandSet) = length(iter)
