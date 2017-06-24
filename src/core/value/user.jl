## user values (<: llvm::User)

# operand iteration

export operands

import Base: eltype, getindex, setindex!, start, next, done, length, endof

immutable UserOperandSet
    user::User
end

operands(user::User) = UserOperandSet(user)

eltype(::UserOperandSet) = Value

getindex(iter::UserOperandSet, i) =
    Value(API.LLVMGetOperand(ref(iter.user), Cuint(i-1)))

setindex!(iter::UserOperandSet, val::Value, i) =
    API.LLVMSetOperand(ref(iter.user), Cuint(i-1), ref(val))

start(iter::UserOperandSet) = (1,length(iter))

next(iter::UserOperandSet, state) =
    (iter[state[1]], (state[1]+1,state[2]))

done(::UserOperandSet, state) = (state[1] > state[2])

length(iter::UserOperandSet) = API.LLVMGetNumOperands(ref(iter.user))
endof(iter::UserOperandSet) = length(iter)
