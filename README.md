# NASM — Repositório de Exercícios em Assembly x86-64

Este repositório reúne meus exercícios e experimentos em Assembly (NASM), principalmente inspirados nos exercícios do curso de Python do Guanabara, além de implementações de funções matemáticas, manipulação de structs, syscalls e um esboço de servidor TCP em C (pré-trabalho para a versão em Assembly).

---

## Conteúdo

- **ex_guanabara_assembly/** — exercícios recriados do curso do Guanabara em Assembly (até o exercício 6 completos, o exercício 7 começado)  
- **Funções matemáticas em ponto flutuante** — implementação de raiz quadrada (aproximação), `ln(x)` e operações usando o expoente da representação IEEE 754  
- **Uso de `struc` no NASM** — para organização de dados em structs  
- **Syscalls** — função geradora de inteiros pseudo-aleatórios usando `sys_gettimeofday` 
- **Servidor TCP (em C, prévia para versão em ASM)** — código servidor TCP + parte web (HTML / CSS / JS) + persistência com SQLite  

Página estática que fiz para testar o servidor: https://danilovieiracosta1729.github.io/NASM/index.html
Acabei aprendendo coisas legais de front-end fazendo isso, então foi uma experiência muito enriquecedora para mim.
