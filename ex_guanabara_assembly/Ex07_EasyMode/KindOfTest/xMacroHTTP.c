#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define JSON_STUDENT(learner, buffer) \
    Xs(nome, (learner)->name, (buffer)) \
    Xs(cpf, (learner)->cpf, (buffer)) \
    Xi(nota1, (learner)->score1, (buffer)) \
    Xi(nota2, (learner)->score2, (buffer)) \
    Xie(nota3, (learner)->score3, (buffer)) 

typedef struct {
    char name[64];
    char cpf[16];
    int8_t score1;
    int8_t score2;
    int8_t score3;
} student;

int main(int argc, char const *argv[])
{
    student * aluno = (student *)malloc(sizeof(student));

    strncpy(aluno->cpf, "00000000011", 11);
    strncpy(aluno->name, "Euclides", 7);
    aluno->score1 = 10;
    aluno->score2 = 9;
    aluno->score3 = 7;

    char http[512] = {0};
    http[0] = '{';

    #define Xs(chave, valor, buffer) sprintf(buffer + strlen(buffer), "\"%s\":\"%s\",", #chave, valor);
    #define Xi(chave, valor, buffer) sprintf(buffer + strlen(buffer), "\"%s\":%d,", #chave, valor);
    #define Xie(chave, valor, buffer) sprintf(buffer + strlen(buffer), "\"%s\":%d}", #chave, valor);
        JSON_STUDENT(aluno, http)
    #undef Xi
    #undef Xs
    #undef Xie

    printf("%s\n", http);
    

    free(aluno);

    return 0;
}
