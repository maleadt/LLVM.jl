ifndef LLVM_CONFIG
$(error LLVM_CONFIG is not set)
endif

TARGET  = libLLVM_extra.so
SOURCES = $(shell find -name '*.cpp')
OBJECTS = $(SOURCES:.cpp=.o)

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
