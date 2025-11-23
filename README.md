# NASM — Repositório de Exercícios em Assembly x86-64

Este repositório reúne meus exercícios e experimentos em Assembly (NASM), principalmente inspirados nos exercícios do curso de Python do Guanabara, além de implementações de funções matemáticas, manipulação de structs, syscalls e um esboço de servidor TCP em C (pré-trabalho para a versão em Assembly).

---

## Conteúdo

- **ex_guanabara_assembly/** — exercícios recriados do curso do Guanabara em Assembly (até o exercício 6 completos, o exercício 7 começado)  
- **Funções matemáticas em ponto flutuante** — implementação de raiz quadrada (aproximação), `ln(x)` e operações usando representação IEEE 754  
- **Uso de `struc` no NASM** — para organização de dados em structs  
- **Syscalls** — função geradora de inteiros pseudo-aleatórios usando `sys_gettimeofday` 
- **Servidor TCP (em C, prévia para versão em ASM)** — código cliente/servidor TCP + parte web (HTML / CSS) + persistência com SQLite  

---

## Motivação e Objetivo

- Recriar os exercícios de Python do Guanabara para exercitar lógica e controle de fluxo em Assembly  
- Explorar como representar e operar sobre números de ponto flutuante, usando a norma IEEE 754, em Assembly  
- Desenvolver abstrações de dados (structs) diretamente em NASM  
- Aprender a usar syscalls para funcionalidades de sistema, como geração de números aleatórios  
- Preparar a base para um servidor TCP em Assembly, começando pela versão em C para prototipação rápida  

---

## Principais Implementações

1. **Aproximação de raiz quadrada**  
   - Utiliza a representação IEEE 754 para extrair o piso de log₂.  
   - Usa constantes e operações aritméticas para obter a raiz.  

2. **Função `ln(x)`**  
   - Cálculo de logaritmo natural usando operações aritméticas e manipulação de ponto flutuante em Assembly.

3. **Manipulação de `struct` no NASM**  
   - Uso de diretivas `struc` para definir estruturas de dados com campos nomeados.  
   - Alternância entre dados estáticos e acesso por deslocamento.

4. **Inteiros pseudo-aleatórios (syscall)**  
   - Função que chama `sys_gettimeofday` (syscall 96) para obter tempo atual e gerar números pseudo-aleatórios.  
   - Embora esteja em outro repositório, a ideia guia projetos futuros em Assembly.

5. **Servidor TCP (protótipo em C)**  
   - Implementação de servidor e cliente TCP simples para troca de mensagens.  
   - Persistência em SQLite para armazenamento de dados.  
   - Front-end básico em HTML/CSS para interação via navegador.

---

## Como Compilar e Executar

### Requisitos

- NASM  
- GCC (para compilar o código C)  
- SQLite (biblioteca para a versão em C)  
- Make (opcional, se você quiser automatizar a build)

### Exemplos

**Para os arquivos .asm**:

```bash
nasm -f elf64 nome_do_arquivo.asm -o nome_do_arquivo.o  
ld nome_do_arquivo.o -o nome_do_executavel  
./nome_do_executavel
