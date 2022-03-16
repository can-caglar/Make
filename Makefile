# Compiler variables
CC=gcc
CFLAGS=-Wall

# DIR variables
SRCDIR=src
OBJDIR=obj
INCLUDEDIR=include
BUILDDIR=build

# $(wildcard ) is a function. It makes sure the * symbol is treated as a wildcard and not a simple string.
SRCS=$(wildcard $(SRCDIR)/*.c)

# Translation: Make OBJS equal to SRCS, however for every SRCS with the name that matches $(SRCDIR)/%.c, assign it to $(OBJDIR)/%.o
OBJS=$(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

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

# To create obj files need to compile the .c files
$(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $? -o $@ $(INCLUDE)

# Debug recipe to make sure our string replacements are good
debug:
	@echo Test
	@echo "SRC = $(SRCS)"
	@echo "OBJS = $(OBJS)"
	@echo "copy command is = $@ $(BUILDDIR)/."

# Clean everything
clean:
	rm *.exe $(OBJDIR)/*.o $(BUILDDIR)/*.exe