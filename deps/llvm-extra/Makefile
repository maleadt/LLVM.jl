ifndef LLVM_CONFIG
$(error LLVM_CONFIG is not set)
endif

TARGET  = libLLVM_extra.so
SOURCES = $(shell echo *.c)
OBJECTS = $(SOURCES:.c=.o)

CPPFLAGS = $(shell $(LLVM_CONFIG) --cppflags)
CFLAGS = $(shell $(LLVM_CONFIG) --cflags)
LDFLAGS = $(shell $(LLVM_CONFIG) --ldflags)
LDLIBS = -lLLVM $(shell $(LLVM_CONFIG) --system-libs)

# add LLVM's libdir to our RPATH, making sure we only pick up the correct library
LLVM_LIBDIR=`$(LLVM_CONFIG) --libdir`
LDFLAGS += "-Wl,-rpath,$(LLVM_LIBDIR)"

# sanitize the cflags llvm-config provides us with
# (removing C++ specific ones, or flags supported by only Clang or GCC)
BADFLAGS = -Wcovered-switch-default -fcolor-diagnostics -Wdelete-non-virtual-dtor
CFLAGS := $(filter-out $(BADFLAGS),$(CFLAGS))

# shared-library building
CFLAGS += -fPIC
%.so:
	$(LINK.cc) -shared $^ $(LDFLAGS) $(LDLIBS) -o $@

.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJECTS)
