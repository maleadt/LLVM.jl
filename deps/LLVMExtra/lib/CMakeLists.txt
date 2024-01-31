add_library(LLVMExtra-${LLVM_VERSION_MAJOR}
  SHARED
  Core.cpp
  NewPM.cpp
)
target_link_libraries(LLVMExtra-${LLVM_VERSION_MAJOR} LLVM)
install(TARGETS LLVMExtra-${LLVM_VERSION_MAJOR} DESTINATION lib)
