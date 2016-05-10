CC	= ../riscv/bin/riscv64-unknown-elf-gcc
CC-HOST	= gcc
TARGET	= bns-riscv
TARGET-HOST	= bns
SPIKE	= ../riscv/bin/spike
SPIKE-OPTION	= --ic=64:1:64 --dc=64:1:64 pk
CHECKER	= checker

bns-riscv: bns.c checker
	$(CC) -o $@ $<

checker: checker.c
	$(CC-HOST) -o $@ $<

.PHONY: clean host run run-host
clean:
	rm -fr $(TARGET) $(TARGET-HOST) $(CHECKER) ./Output/*

host: bns.c bmp.h checker
	$(CC-HOST) -o $(TARGET-HOST) $<

run: 
	$(SPIKE) $(SPIKE-OPTION) $(TARGET)
	./$(CHECKER)

run-host: 
	./$(TARGET-HOST)
	./$(CHECKER)
