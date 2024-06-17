## module and function verification

export verify

function verify(mod::Module)
    out_error = Ref{Cstring}()
    status = API.LLVMVerifyModule(mod, API.LLVMReturnStatusAction, out_error) |> Bool

    if status
        error = unsafe_message(out_error[])
        throw(LLVMException(error))
    end
end

function verify(f::Function)
    status = API.LLVMVerifyFunction(f, API.LLVMReturnStatusAction) |> Bool

    if status
        throw(LLVMException("broken function"))
    end
end


## dominator tree

export DomTree, dominates

@checked struct DomTree
    ref::API.LLVMDominatorTreeRef
end

Base.unsafe_convert(::Type{API.LLVMDominatorTreeRef}, domtree::DomTree) =
    mark_use(domtree).ref

DomTree(f::Function) = mark_alloc(DomTree(API.LLVMCreateDominatorTree(f)))
dispose(domtree::DomTree) = mark_dispose(API.LLVMDisposeDominatorTree, domtree)

function dominates(domtree::DomTree, A::Instruction, B::Instruction)
    API.LLVMDominatorTreeInstructionDominates(domtree, A, B) |> Bool
end


## post-dominator tree

export PostDomTree, dominates

@checked struct PostDomTree
    ref::API.LLVMPostDominatorTreeRef
end

Base.unsafe_convert(::Type{API.LLVMPostDominatorTreeRef}, postdomtree::PostDomTree) =
    mark_use(postdomtree).ref

PostDomTree(f::Function) = mark_alloc(PostDomTree(API.LLVMCreatePostDominatorTree(f)))
dispose(postdomtree::PostDomTree) =
    mark_dispose(API.LLVMDisposePostDominatorTree, postdomtree)

function dominates(postdomtree::PostDomTree, A::Instruction, B::Instruction)
    API.LLVMPostDominatorTreeInstructionDominates(postdomtree, A, B) |> Bool
end
