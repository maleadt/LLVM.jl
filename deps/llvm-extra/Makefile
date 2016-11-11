# NOTE: this Makefile is only to be invoked from build.jl
#       if running manually, make sure you provide all required environment variables

UNAME = $(shell uname -s)


#
# LLVM flags
#

CPPFLAGS = $(shell $(LLVM_CONFIG) --cppflags)
CXXFLAGS = $(shell $(LLVM_CONFIG) --cxxflags)
LDFLAGS = $(shell $(LLVM_CONFIG) --ldflags)
LDLIBS = $(shell $(LLVM_CONFIG) --system-libs)

# NOTE: we don't link against libLLVM for the resulting library to be portable
#       (ie. not tied to a specific name/location of libLLVM)
#       a linked version is created by build.jl

# sanitize the cflags llvm-config provides us with
# (removing C++ specific ones, or flags supported by only Clang or GCC)
BADFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor -gline-tables-only
CXXFLAGS := $(filter-out $(BADFLAGS),$(CXXFLAGS))

# handle RTTI flags
HAS_RTTI=$(shell $(LLVM_CONFIG) --has-rtti)
ifneq ($(HAS_RTTI),"YES")
CXXFLAGS += -fno-rtti
endif

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

CXXFLAGS += $(shell $(JULIA_BINARY) $(JULIA_CONFIG) --cflags)
LDFLAGS += $(shell $(JULIA_BINARY) $(JULIA_CONFIG) --ldflags)

# NOTE: we don't link against libjulia as it will be loaded when dlopen'ing this library


#
# Build
#

ifeq ($(UNAME), Darwin)
  SLIB := dylib
else
  SLIB := so
endif

TARGET  = libLLVM_extra-$(LLVM_VERSION)_$(JULIA_VERSION).$(SLIB)
SOURCES = $(shell find . -name '*.cpp')
OBJECTS = $(SOURCES:.cpp=.o)

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
