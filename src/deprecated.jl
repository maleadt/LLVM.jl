# deprecated methods

@deprecate called_value(inst::CallBase) called_operand(inst)

@deprecate has_orc_v1() false false
@deprecate has_orc_v2() true false
@deprecate has_newpm() true false
@deprecate has_julia_ojit() true false

Base.@deprecate_binding InstructionMetadataDict LLVM.ValueMetadataDict
