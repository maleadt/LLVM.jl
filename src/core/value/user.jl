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

Base.start(iter::UserOperandSet) = (1,length(iter))

Base.next(iter::UserOperandSet, state) =
    (iter[state[1]], (state[1]+1,state[2]))

Base.done(::UserOperandSet, state) = (state[1] > state[2])

Base.length(iter::UserOperandSet) = API.LLVMGetNumOperands(ref(iter.user))

Base.lastindex(iter::UserOperandSet) = length(iter)
