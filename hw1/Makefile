OFILES= main.o scanner.o grammar.o parser.o
CPATH=
LEX = flex
BISON = bison
LLVMASY=$(CPATH)llvm-as
LLVMOPT=$(CPATH)opt
LLVMLC=$(CPATH)llc
CC=$(CPATH)clang++
LD = $(CPATH)clang++
CXXFLAGS=`$(CPATH)llvm-config --cppflags` -std=c++11 -Wno-deprecated-register
LDFLAGS=`$(CPATH)llvm-config --ldflags --system-libs --libs engine`

AS=as

all: grammar.c nightfury 

grammar.c grammar.h: grammar.y 
	$(BISON) --debug -d $< -o grammar.c

scanner.c: scanner.lex grammar.h
	$(LEX) --bison-bridge -o $@ $<

%.o : %.s
	$(AS) $< -o $@

%.s : %.bc
	$(LLVMLC) $< -o $@

%.bc : %.llvm
	$(LLVMASY) $< -o $@

nightfury: grammar.c grammar.h scanner.c $(OFILES) 
	$(LD) -g $(OFILES) $(LDFLAGS) -o $@

%.o %.d : %.C
	$(CC) -g -c -x c++ $(CXXFLAGS) $< -MD 

%.o %.d : %.c
	$(CC) -g -c -x c++ $(CXXFLAGS) $< -MD

clean: 
	rm -rf *.o *~ scanner.c *.d nightfury grammar.c grammar.h

#include $(addsuffix .d ,$(basename $(OFILES)))

