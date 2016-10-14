ifndef CALLED_FROM_JULIA
$(error This Makefile can only be invoked from Julia)
endif

TARGET  = libLLVM_extra.so
SOURCES = $(shell find -name '*.cpp')
OBJECTS = $(SOURCES:.cpp=.o)


#
# LLVM flags
#

CPPFLAGS = $(shell $(LLVM_CONFIG) --cppflags)
CXXFLAGS = $(shell $(LLVM_CONFIG) --cxxflags)
LDFLAGS = $(shell $(LLVM_CONFIG) --ldflags) -Wl,-z,defs
LDLIBS = -lLLVM $(shell $(LLVM_CONFIG) --system-libs)

# add LLVM's libdir to our RPATH, making sure we only pick up the correct library
LLVM_LIBDIR = $(shell $(LLVM_CONFIG) --libdir)
LDFLAGS += "-Wl,-rpath,$(LLVM_LIBDIR)"

# sanitize the cflags llvm-config provides us with
# (removing C++ specific ones, or flags supported by only Clang or GCC)
BADFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor
CXXFLAGS := $(filter-out $(BADFLAGS),$(CXXFLAGS))

# as we build with -z,defs, we shouldn't use target-specific symbols
# unless the target is built, so generate preprocessor definitions
LLVM_TARGETS = $(shell $(LLVM_CONFIG) --targets-built | tr '[:lower:]' '[:upper:]')
CPPFLAGS += $(addprefix -DTARGET_, $(LLVM_TARGETS))

# try to detect LLVM's C++ ABI, and configure GLIBC accordingly
# NOTE: this is best-effort, as the target compiler might just not support the new ABI
OBJDUMP := $(shell command -v objdump 2> /dev/null)
ifdef OBJDUMP
CXX11_SYMBOLS=$(shell objdump -tT "$(LLVM_LIBRARY)" | grep -E "(_cxx11|B5cxx11)")
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

# shared-library building
# NOTE: we create our own version of libLLVM including all of its static libraries.
#       This isn't necessary per se, but prevents conflicts with loading libLLVM
#       multiple times (in which case initialization functions can't be called twice)
CXXFLAGS += -fPIC
%.so:
	$(LINK.cc) -shared $^ $(LDFLAGS) $(LDLIBS) -o $@

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJECTS)

.PHONY: format
format:
	$(shell $(LLVM_CONFIG) --bindir)/clang-format -style=LLVM -i $(SOURCES)
