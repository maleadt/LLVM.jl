ifndef LLVM_CONFIG
$(error LLVM_CONFIG is not set)
endif

TARGET  = libLLVM_extra.so
SOURCES = $(shell echo *.c)
OBJECTS = $(SOURCES:.c=.o)

CPPFLAGS = $(shell $(LLVM_CONFIG) --cppflags)
CFLAGS = $(shell $(LLVM_CONFIG) --cflags)
LDFLAGS = $(shell $(LLVM_CONFIG) --ldflags) -Wl,-z,defs
LDLIBS = $(shell $(LLVM_CONFIG) --system-libs) -ledit

# sanitize the cflags llvm-config provides us with
# (removing C++ specific ones, or flags supported by only Clang or GCC)
BADFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor
CFLAGS := $(filter-out $(BADFLAGS),$(CFLAGS))

# shared-library building
# NOTE: we create our own version of libLLVM including all of its static libraries.
#       This isn't necessary per se, but prevents conflicts with loading libLLVM
#       multiple times (in which case initialization functions can't be called twice)
STATIC_LIBS = $(shell $(LLVM_CONFIG) --libs)
CFLAGS += -fPIC
%.so:
	$(LINK.cc) -shared $^ $(LDFLAGS) $(LDLIBS) -Wl,--whole-archive $(STATIC_LIBS) -Wl,--no-whole-archive -o $@

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJECTS)
