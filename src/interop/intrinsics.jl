export trap, assume

@inline trap() = ccall("llvm.trap", llvmcall, Cvoid, ())

if VERSION >= v"1.6.0-DEV.674"
    @inline assume(cond::Bool) = Base.llvmcall(("""
            declare void @llvm.assume(i1)

            define void @entry(i8) #0 {
                %cond = icmp eq i8 %0, 1
                call void @llvm.assume(i1 %cond)
                ret void
            }

            attributes #0 = { alwaysinline }""", "entry"),
        Nothing, Tuple{Bool}, cond)
else
    @inline assume(cond::Bool) = Base.llvmcall(("declare void @llvm.assume(i1)", """
            %cond = icmp eq i8 %0, 1
            call void @llvm.assume(i1 %cond)
            ret void"""),
        Nothing, Tuple{Bool}, cond)
end
# do-block syntax
@inline function assume(f::F, val...) where {F}
    assume(f(val...))
    return val
end
