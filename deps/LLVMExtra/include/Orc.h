#ifndef LLVMEXTRA_ORC_H
#define LLVMEXTRA_ORC_H

#include <llvm-c/Core.h>
#include <llvm-c/Orc.h>

#if LLVM_VERSION_MAJOR == 12

LLVM_C_EXTERN_C_BEGIN

typedef enum {
  LLVMJITSymbolGenericFlagsCallable = 1U << 2,
  LLVMJITSymbolGenericFlagsMaterializationSideEffectsOnly = 1U << 3
} LLVMExtraJITSymbolGenericFlags;

/**
 * Represents a pair of a symbol name and LLVMJITSymbolFlags.
 */
typedef struct {
  LLVMOrcSymbolStringPoolEntryRef Name;
  LLVMJITSymbolFlags Flags;
} LLVMOrcCSymbolFlagsMapPair;

/**
 * Represents a list of (SymbolStringPtr, JITSymbolFlags) pairs that can be used
 * to construct a SymbolFlagsMap.
 */
typedef LLVMOrcCSymbolFlagsMapPair *LLVMOrcCSymbolFlagsMapPairs;

/**
 * Represents a SymbolAliasMapEntry
 */
typedef struct {
    LLVMOrcSymbolStringPoolEntryRef Name;
    LLVMJITSymbolFlags Flags;
} LLVMOrcCSymbolAliasMapEntry;

/**
 * Represents a pair of a symbol name and SymbolAliasMapEntry.
 */
typedef struct {
    LLVMOrcSymbolStringPoolEntryRef Name;
    LLVMOrcCSymbolAliasMapEntry Entry;
} LLVMOrcCSymbolAliasMapPair;

/**
 * Represents a list of (SymbolStringPtr, (SymbolStringPtr, JITSymbolFlags))
 * pairs that can be used to construct a SymbolFlagsMap.
 */
typedef LLVMOrcCSymbolAliasMapPair *LLVMOrcCSymbolAliasMapPairs;

/**
 * A reference to a uniquely owned orc::MaterializationResponsibility instance.
 *
 * Ownership must be passed to a lower-level layer in a JIT stack.
 */
typedef struct LLVMOrcOpaqueMaterializationResponsibility
    *LLVMOrcMaterializationResponsibilityRef;

/**
 * A MaterializationUnit materialize callback.
 *
 * Ownership of the Ctx and MR arguments passes to the callback which must
 * adhere to the LLVMOrcMaterializationResponsibilityRef contract (see comment
 * for that type).
 *
 * If this callback is called then the LLVMOrcMaterializationUnitDestroy
 * callback will NOT be called.
 */
typedef void (*LLVMOrcMaterializationUnitMaterializeFunction)(
    void *Ctx, LLVMOrcMaterializationResponsibilityRef MR);

/**
 * A MaterializationUnit discard callback.
 *
 * Ownership of JD and Symbol remain with the caller: These arguments should
 * not be disposed of or released.
 */
typedef void (*LLVMOrcMaterializationUnitDiscardFunction)(
    void *Ctx, LLVMOrcJITDylibRef JD, LLVMOrcSymbolStringPoolEntryRef Symbol);

/**
 * A MaterializationUnit destruction callback.
 *
 * If a custom MaterializationUnit is destroyed before its Materialize
 * function is called then this function will be called to provide an
 * opportunity for the underlying program representation to be destroyed.
 */
typedef void (*LLVMOrcMaterializationUnitDestroyFunction)(void *Ctx);

/**
 * A function for inspecting/mutating IR modules, suitable for use with
 * LLVMOrcThreadSafeModuleWithModuleDo.
 */
typedef LLVMErrorRef (*LLVMOrcGenericIRModuleOperationFunction)(
    void *Ctx, LLVMModuleRef M);

/**
 * A reference to an orc::IRTransformLayer instance.
 */
typedef struct LLVMOrcOpaqueIRTransformLayer *LLVMOrcIRTransformLayerRef;

/**
 * A function for applying transformations as part of an transform layer.
 *
 * Implementations of this type are responsible for managing the lifetime
 * of the Module pointed to by ModInOut: If the LLVMModuleRef value is
 * overwritten then the function is responsible for disposing of the incoming
 * module. If the module is simply accessed/mutated in-place then ownership
 * returns to the caller and the function does not need to do any lifetime
 * management.
 *
 * Clients can call LLVMOrcLLJITGetIRTransformLayer to obtain the transform
 * layer of a LLJIT instance, and use LLVMOrcIRTransformLayerSetTransform
 * to set the function. This can be used to override the default transform
 * layer.
 */
typedef LLVMErrorRef (*LLVMOrcIRTransformLayerTransformFunction)(
    void *Ctx, LLVMOrcThreadSafeModuleRef *ModInOut,
    LLVMOrcMaterializationResponsibilityRef MR);

/**
 * A reference to an orc::IndirectStubsManager instance.
 */
typedef struct LLVMOrcOpaqueIndirectStubsManager
    *LLVMOrcIndirectStubsManagerRef;

/**
 * A reference to an orc::LazyCallThroughManager instance.
 */
typedef struct LLVMOrcOpaqueLazyCallThroughManager
    *LLVMOrcLazyCallThroughManagerRef;

/**
 * Create a custom MaterializationUnit.
 *
 * Name is a name for this MaterializationUnit to be used for identification
 * and logging purposes (e.g. if this MaterializationUnit produces an
 * object buffer then the name of that buffer will be derived from this name).
 *
 * The Syms list contains the names and linkages of the symbols provided by this
 * unit. This function takes ownership of the elements of the Syms array. The
 * Name fields of the array elements are taken to have been retained for this
 * function. The client should *not* release the elements of the array, but is
 * still responsible for destroyingthe array itself.
 *
 * The InitSym argument indicates whether or not this MaterializationUnit
 * contains static initializers. If three are no static initializers (the common
 * case) then this argument should be null. If there are static initializers
 * then InitSym should be set to a unique name that also appears in the Syms
 * list with the LLVMJITSymbolGenericFlagsMaterializationSideEffectsOnly flag
 * set. This function takes ownership of the InitSym, which should have been
 * retained twice on behalf of this function: once for the Syms entry and once
 * for InitSym. If clients wish to use the InitSym value after this function
 * returns they must retain it once more for themselves.
 *
 * If any of the symbols in the Syms list is looked up then the Materialize
 * function will be called.
 *
 * If any of the symbols in the Syms list is overridden then the Discard
 * function will be called.
 *
 * The caller owns the underling MaterializationUnit and is responsible for
 * either passing it to a JITDylib (via LLVMOrcJITDylibDefine) or disposing
 * of it by calling LLVMOrcDisposeMaterializationUnit.
 */
LLVMOrcMaterializationUnitRef LLVMOrcCreateCustomMaterializationUnit(
    const char *Name, void *Ctx, LLVMOrcCSymbolFlagsMapPairs Syms,
    size_t NumSyms, LLVMOrcSymbolStringPoolEntryRef InitSym,
    LLVMOrcMaterializationUnitMaterializeFunction Materialize,
    LLVMOrcMaterializationUnitDiscardFunction Discard,
    LLVMOrcMaterializationUnitDestroyFunction Destroy);

LLVMOrcMaterializationUnitRef
LLVMOrcLazyReexports(LLVMOrcLazyCallThroughManagerRef LCTM,
    LLVMOrcIndirectStubsManagerRef ISM,
    LLVMOrcJITDylibRef SourceRef,
    LLVMOrcCSymbolAliasMapPairs CallableAliases,
    size_t NumPairs);

LLVMOrcJITDylibRef LLVMOrcMaterializationResponsibilityGetTargetDylib(
    LLVMOrcMaterializationResponsibilityRef MR);

LLVMOrcExecutionSessionRef
LLVMOrcMaterializationResponsibilityGetExecutionSession(
    LLVMOrcMaterializationResponsibilityRef MR);

LLVMOrcSymbolStringPoolEntryRef
LLVMOrcMaterializationResponsibilityGetInitializerSymbol(
    LLVMOrcMaterializationResponsibilityRef MR);

LLVMOrcSymbolStringPoolEntryRef *LLVMOrcMaterializationResponsibilityGetRequestedSymbols(
    LLVMOrcMaterializationResponsibilityRef MR, size_t *NumSymbols);

void LLVMOrcDisposeSymbols(LLVMOrcSymbolStringPoolEntryRef *Symbols);

LLVMErrorRef
LLVMOrcMaterializationResponsibilityNotifyResolved(
    LLVMOrcMaterializationResponsibilityRef MR, LLVMOrcCSymbolMapPairs Symbols,
    size_t NumPairs);

LLVMErrorRef
LLVMOrcMaterializationResponsibilityNotifyEmitted(
    LLVMOrcMaterializationResponsibilityRef MR);

void LLVMOrcMaterializationResponsibilityFailMaterialization(
    LLVMOrcMaterializationResponsibilityRef MR);

/**
 * Apply the given function to the module contained in this ThreadSafeModule.
 */
LLVMErrorRef
LLVMOrcThreadSafeModuleWithModuleDo(LLVMOrcThreadSafeModuleRef TSM,
                                    LLVMOrcGenericIRModuleOperationFunction F,
                                    void *Ctx);

void LLVMOrcIRTransformLayerEmit(LLVMOrcIRTransformLayerRef IRTransformLayer,
                        LLVMOrcMaterializationResponsibilityRef MR,
                        LLVMOrcThreadSafeModuleRef TSM);

/**
 * Create a LocalIndirectStubsManager from the given target triple.
 *
 * The resulting IndirectStubsManager is owned by the client
 * and must be disposed of by calling LLVMOrcDisposeDisposeIndirectStubsManager.
 */
LLVMOrcIndirectStubsManagerRef LLVMOrcCreateLocalIndirectStubsManager(
    const char *TargetTriple);

/**
 * Dispose of an IndirectStubsManager.
 */
void LLVMOrcDisposeIndirectStubsManager(LLVMOrcIndirectStubsManagerRef ISM);

LLVMErrorRef LLVMOrcCreateLocalLazyCallThroughManager(
    const char *TargetTriple, LLVMOrcExecutionSessionRef ES,
    LLVMOrcJITTargetAddress ErrorHandlerAddr,
    LLVMOrcLazyCallThroughManagerRef *Result);

/**
 * Dispose of an LazyCallThroughManager.
 */
void LLVMOrcDisposeLazyCallThroughManager(LLVMOrcLazyCallThroughManagerRef LCM);


LLVM_C_EXTERN_C_END
#endif
#endif // LLVMEXTRA_ORC_H
