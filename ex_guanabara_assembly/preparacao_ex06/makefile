# Nome do executável final
TARGET = teste

# Arquivos de entrada .asm
SRC = testaRaiz.asm parserSD_versao4.asm raiz.asm exp.asm myLog.asm

# Gera a lista de objetos correspondente
OBJ = $(SRC:.asm=.o)

# Compilador NASM
NASM = nasm
NASMFLAGS = -f elf64 -g -F dwarf   # formato ELF64, com debug info

# Linker
CC = gcc
LDFLAGS = -no-pie   # executável sem PIE, facilita debugar no assembly

# Regra padrão
all: $(TARGET)

# Linkagem
$(TARGET): $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

# Compilação de cada .asm para .o
%.o: %.asm
	$(NASM) $(NASMFLAGS) -o $@ $<

# Limpeza
clean:
	rm -f $(OBJ) $(TARGET)
