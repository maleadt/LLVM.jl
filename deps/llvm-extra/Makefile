# NOTE: this Makefile is only to be invoked from build.jl
#       if running manually, make sure you provide all required environment variables

UNAME = $(shell uname -s)


#
# LLVM flags
#

CPPFLAGS = $(shell $(LLVM_CONFIG) --cppflags)
LDFLAGS = $(shell $(LLVM_CONFIG) --ldflags)
LDLIBS = $(shell $(LLVM_CONFIG) --system-libs)

LLVM_CXXFLAGS = $(shell $(LLVM_CONFIG) --cxxflags)
# filter out Clang/GCC specific options
BAD_LLVM_CXXFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor -gline-tables-only -Wstring-conversion
CXXFLAGS = $(filter-out $(BAD_LLVM_CXXFLAGS),$(LLVM_CXXFLAGS))

LDFLAGS += "-Wl,-rpath,$(dir $(LLVM_LIBRARY))"
ifeq ($(UNAME), Darwin)
  # macOS dylibs are versioned already
  LDLIBS += -lLLVM

  # some LLVM libraries erroneously link against libLTO (D25865), provided by Julia too.
  # however, loading libLLVM only picks up / prioritizes the Julia RPATH, loading the
  # wrong version of libLTO. workaround: link against the correct libLTO ourselves.
  #
  # NOTE: I haven't seen this arise on Linux, but might very well happen there too.
  OTOOL := $(shell command -v otool 2> /dev/null)
  ifdef OTOOL
    LIBLTO=$(shell $(OTOOL) -L "$(LLVM_LIBRARY)" | grep "libLTO")
    ifneq ($(LIBLTO),)
      LDLIBS += -lLTO
    endif
  else
    $(error otool not available)
  endif

  # NOTE: we wouldn't need the above hack, or the rpath additions,
  #       if libLLVM/libLTO had a proper `install_path` set-up
else
  # specify the versioned library name to make sure we pick up the correct one
  LDLIBS += -l:$(notdir $(LLVM_LIBRARY))
endif

# handle RTTI flags
HAS_RTTI=$(shell $(LLVM_CONFIG) --has-rtti)
ifneq ($(HAS_RTTI),"YES")
CXXFLAGS += -fno-rtti
endif

# we shouldn't use target-specific symbols unless the target is built,
# so generate preprocessor definitions
LLVM_TARGETS = $(shell $(LLVM_CONFIG) --targets-built | tr '[:lower:]' '[:upper:]')
CPPFLAGS += $(addprefix -DTARGET_, $(LLVM_TARGETS))

# try to detect LLVM's C++ ABI, and configure GLIBC accordingly
# NOTE: this is best-effort, as the target compiler might just not support the new ABI
NM := $(shell command -v nm 2> /dev/null)
ifdef NM
  ifeq ($(UNAME),Linux)
    CXX11_SYMBOLS=$(shell $(NM) -D "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
  endif
  ifeq ($(UNAME),Darwin)
    CXX11_SYMBOLS=$(shell $(NM) -g "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
  endif
  ifeq ($(CXX11_SYMBOLS),)
    CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=0
  else
    CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=1
  endif
else
  $(warning nm not available, cannot detect C++11 ABI)
endif


#
# Julia flags
#

LDFLAGS += $(shell $(JULIA_BINARY) $(JULIA_CONFIG) --ldflags)

JULIA_CXXFLAGS = $(shell $(JULIA_BINARY) $(JULIA_CONFIG) --cflags)
# filter out Julia's -std, which is C specific.
BAD_JULIA_CXXFLAGS=-std=%
CXXFLAGS += $(filter-out $(BAD_JULIA_CXXFLAGS),$(JULIA_CXXFLAGS))

# NOTE: we don't link against libjulia as it will be loaded when dlopen'ing this library

# as a consequence, the library will contain undefined references to Julia functions,
# which macOS tools don't like
JULIA_FUNCTIONS = jl_get_ptls_states jl_box_voidpointer jl_unbox_bool jl_apply_generic
COMMA := ,
ifeq ($(UNAME), Darwin)
  LDFLAGS += $(addprefix -Wl$(COMMA)-U$(COMMA)_,$(JULIA_FUNCTIONS))
endif


#
# Build
#

CXXFLAGS += $(EXTRA_CXXFLAGS)

ifeq ($(UNAME), Darwin)
  SLIB := dylib
else
  SLIB := so
endif

TARGET  = libLLVM_extra.$(SLIB)
SOURCES = $(shell find . -name '*.cpp')
OBJECTS = $(SOURCES:.cpp=.o)

ifeq ($(UNAME), Darwin)
$(TARGET): LDFLAGS += -install_name $(ROOT_DIR)/$(TARGET)
endif

# shared-library building
CXXFLAGS += -fPIC
%.$(SLIB):
	$(LINK.cc) -shared $^ $(LDFLAGS) $(LDLIBS) -o $@

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJECTS)

CLANG_FORMAT ?= $(shell $(LLVM_CONFIG) --bindir)/clang-format
.PHONY: format
format:
	$(CLANG_FORMAT) -style=LLVM -i $(SOURCES)
