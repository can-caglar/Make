# Compiler variables
CC=gcc
# Magic incantation to produce dependency files to help Make rebuild when
# .h files change.
DEPFLAGS=-MP -MD
CFLAGS=-Wall -Wextra -g $(DEPFLAGS)

# Project directories (note, we could use a foreach loop below and have multiple of each directory)
# Like: SRCS=$(foreach D,$(SRCDIR),$(wildcard $(D)/*.c))
SRCDIR=src
OBJDIR=obj
INCLUDEDIR=include
BUILDDIR=build

# $(wildcard ) is a function. It makes sure the * symbol is treated as a wildcard and not a simple string.
SRCS=$(wildcard $(SRCDIR)/*.c)

# Translation: Make OBJS equal to SRCS, however for every SRCS with the name that matches $(SRCDIR)/%.c, assign it to $(OBJDIR)/%.o
OBJS=$(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

# patsubst function (patsubst from, to, where). Note: Add -include to include these as dependencies!
DEPFILES=$(patsubst %.o,%.d,$(OBJS))

# Where to search for additional header files in the compilation unit.
INCLUDE=-I./$(INCLUDEDIR)

# .PHONY tells Make that these are not real recipes: we're not lookign to make "debug" or "clean" files.
.PHONY = debug clean

# This is the first recipe from the top, so it will be called first.
# Its dependencies are "debug" and "main". Will try to look for their recipes and build them.
all: debug main

# The last step, linking obj files to create executable
# This recipe has 2 commands. the second one copies the executable from root to builddir.
main: $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@
	cp $@ $(BUILDDIR)/.

# To create obj files need to compile the .c files. Note we are using $< to
# prevent the header file being part of the compilation files
# (due to the -MP -MD flag (see top))
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@ $(INCLUDE)

# Debug recipe to make sure our string replacements are good
debug:
	@echo ---- Test start ----
	@echo "SRC = $(SRCS)"
	@echo "OBJS = $(OBJS)"
	@echo "copy command is = $@ $(BUILDDIR)/."
	@echo "Depfiles is = $(DEPFILES)"
	@echo ---- Test end ----

# Clean everything
clean:
	rm *.exe $(OBJDIR)/*.o $(OBJDIR)/*.d $(BUILDDIR)/*.exe

# Make can be used to just call multiple shell commands like git all in one command: "make diff" in this case.
diff:
	$(info Outputs useful Git info:)
	@git status
	@git diff --stat

-include $(DEPFILES)
