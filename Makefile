CC = clang
CFLAGS = -std=c17 -O0 -g -Wall -MMD -fPIC
LDFLAGS = -framework Cocoa
INCLUDE = -I.
BUILDDIR = ./_build
LDINCLUDE = 
BIN = main
APPNAME = Play

SRCS = $(wildcard src/*.m src/**/*.m)
OBJS = $(foreach obj, $(SRCS:.m=.o), $(BUILDDIR)/$(obj))

.PHONY: all clean

all: $(BUILDDIR)/$(BIN)
	@echo "Packaging"
	@mkdir -p $(BUILDDIR)/$(APPNAME).app/Contents/MacOS/
	@cp ./Info.plist $(BUILDDIR)/$(APPNAME).app/Contents/
	@cp $(BUILDDIR)/$(BIN) $(BUILDDIR)/$(APPNAME).app/Contents/MacOS/

$(BUILDDIR)/$(BIN): $(OBJS)
	$(CC) $^ -o $(BUILDDIR)/$(BIN) $(CFLAGS) $(INCLUDE) $(LDINCLUDE) $(LDFLAGS)

$(OBJS): $(BUILDDIR)/%.o: %.m
	@mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) -o $@ $< $(INCLUDE)

-include $(OBJS:%.o=%.d)

clean:
	@rm -rf $(BUILDDIR)

print-%  : ; @echo $* = $($*)
