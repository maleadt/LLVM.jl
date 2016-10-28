# NOTE: this Makefile is only to be invoked from build.jl
#       if running manually, make sure you provide all required environment variables

UNAME = $(shell uname -s)

ifeq ($(UNAME), Darwin)
  SLIB := dylib
else
  SLIB := so
endif

TARGET  = libLLVM_extra.$(SLIB)
SOURCES = $(shell find . -name '*.cpp')
OBJECTS = $(SOURCES:.cpp=.o)


#
# LLVM flags
#

CPPFLAGS = $(shell $(LLVM_CONFIG) --cppflags)
CXXFLAGS = $(shell $(LLVM_CONFIG) --cxxflags)
LDFLAGS = $(shell $(LLVM_CONFIG) --ldflags)
LDLIBS = $(shell $(LLVM_CONFIG) --system-libs)

LDFLAGS += "-Wl,-rpath,$(dir $(LLVM_LIBRARY))"
ifeq ($(UNAME), Darwin)
  # macOS dylibs are versioned already
  LDLIBS += -lLLVM

  # some LLVM libraries erroneously link against libLTO (D25865), provided by Julia too.
  # however, for some reason loading libLLVM only picks up / prioritizes the Julia RPATH,
  # loading the wrong version of libLTO. workaround: load the correct libLTO ourselves now.
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
else
  # specify the versioned library name to make sure we pick up the correct one
  LDLIBS += -l:$(notdir $(LLVM_LIBRARY))
endif

# sanitize the cflags llvm-config provides us with
# (removing C++ specific ones, or flags supported by only Clang or GCC)
BADFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor -gline-tables-only
CXXFLAGS := $(filter-out $(BADFLAGS),$(CXXFLAGS))

# handle RTTI flags
HAS_RTTI=$(shell $(LLVM_CONFIG) --has-rtti)
ifneq ($(HAS_RTTI),"YES")
CXXFLAGS += -fno-rtti
endif

# as we build with -z,defs, we shouldn't use target-specific symbols
# unless the target is built, so generate preprocessor definitions
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

CXXFLAGS += $(shell $(JULIA) $(JULIA_CONFIG) --cflags)
LDFLAGS += $(shell $(JULIA) $(JULIA_CONFIG) --ldflags)
# NOTE: we don't use the --ldlibs as we don't want to link against libjulia,
#       relying on the fact that the library will be loaded when opening libLLVM_extra.


#
# Build
#

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
