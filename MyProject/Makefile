CC = GCC
DEPFLAGS = -MMD -MP

INCLUDEDIRS = . ./include ../FakeStack/include ../FakeQue/include
SRCDIRS = src ../FakeStack/src ../FakeQue/src
BUILDDIR = build

INCLUDEFLAGS = $(foreach F, $(INCLUDEDIRS), -I$(F))
SRCS = $(foreach S, $(SRCDIRS), $(wildcard $(S)/*.c))

# Below says all object files shall remain in the same dir as their corresponding .c file.
# This makes compiling .c to .o easier too as we won't lose where the .c files originally came from!
# This may be better practice than the commented out version below due to naming collisions and above note.
OBJS = $(foreach SRC, $(SRCS), $(SRC:%.c=%.o))

# Below says all object files shall be found in our builddir. 
# (Syntax: notice there is no '/' outside the dir func as it includes one at the end anyway)
# OBJS = $(foreach SRC, $(SRCS), $(patsubst $(dir $(SRC))%.c, $(BUILDDIR)/%.o, $(SRC)))

# Where dependencies shall live (next to obj files)
DEPS = $(foreach OBJ, $(OBJS), $(OBJ:%.o=%.d))

CFLAGS= -Wall $(DEPFLAGS) $(INCLUDEFLAGS) -O0

.PHONY: all diff clean

all: debug main

debug:
	@echo - - - - - D e b u g - - - - - - -
	@echo INCLUDEFLAGS = $(INCLUDEFLAGS)
	@echo CLAGS = $(CFLAGS)
	@echo SRCS = $(SRCS)
	@echo OBJS = $(OBJS)
	@echo DEPS = $(DEPS)
	@echo - - - - - - - - - - - - - - - - -

main: $(OBJS)
	$(CC) $^ -o  $(BUILDDIR)/$@
	cp  $(BUILDDIR)/$@.exe .

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm $(OBJS) $(DEPS) *.exe $(BUILDDIR)/*.exe

diff:
	git status
	git diff --stat

# The '-' means Make won't complain if include fails.
-include $(DEPS)
