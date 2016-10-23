# NOTE: this Makefile is only to be invoked from build.jl
#       if running manually, make sure you provide all required environment variables

UNAME = $(shell uname)

ifeq ($(UNAME), Darwin)
	SLIB = dylib
else
	SLIB = so
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

# specify a specific rpath and library name to mare sure we pick up the correct library
# NOTE: this doesn't use llvm-config, but uses the LLVM_LIBRARY variable passed by build.jl
LDLIBS += -l:$(notdir $(LLVM_LIBRARY))
LDFLAGS += "-Wl,-rpath,$(dir $(LLVM_LIBRARY))"

# sanitize the cflags llvm-config provides us with
# (removing C++ specific ones, or flags supported by only Clang or GCC)
BADFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor
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
OBJDUMP := $(shell command -v objdump 2> /dev/null)
ifdef OBJDUMP
# CXX11_SYMBOLS=$(shell objdump -tT "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
CXX11_SYMBOLS=$(shell otool -tV "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
ifeq ($(CXX11_SYMBOLS),)
CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=0
else
CPPFLAGS += -D_GLIBCXX_USE_CXX11_ABI=1
endif
else
$(warning "objdump not available, cannot detect C++11 ABI")
endif


#
# Julia flags
#

CXXFLAGS += $(shell $(JULIA) $(JULIA_CONFIG) --cflags)
LDFLAGS += $(shell $(JULIA) $(JULIA_CONFIG) --ldflags)
LDLIBS += $(shell $(JULIA) $(JULIA_CONFIG) --ldlibs)


#
# Build
#

ifeq ($(UNAME), Darwin)
	#LDFLAGS += -Wl
else
	LDFLAGS += -Wl,-z,defs
endif

# shared-library building
CXXFLAGS += -fPIC
%.so:
	$(LINK.cc) -shared $^ $(LDFLAGS) $(LDLIBS) -o $@

%.dylib:
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
