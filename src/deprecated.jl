# deprecated methods

export called_value

Base.@deprecate called_value(inst::CallBase) called_operand(inst)

has_orc_v1() = false
has_orc_v2() = true

Base.@deprecate_binding InstructionMetadataDict LLVM.ValueMetadataDict
