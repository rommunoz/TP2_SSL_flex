#include <stdio.h>
#include <ctype.h>
#include "scanner.h"
#include "tokens.h"
#define DIM_TOKENS 3

//el resto son caracteres o par de caracteres
char* token_names[DIM_TOKENS] = {"Fin de Archivo", "Identificador", "Numero"};

void mostrarToken(enum token t){
    if(t == NL){
        printf("Token: 'NL'\t\n");
    } else if (t < DIM_TOKENS && t <= NUMERO){
        printf("Token: %s\tLexema: %s\n", token_names[t], yytext);
    } else {
        printf("Token: '%s'\t\n", yytext);
    }
}

int main(void){
    int t;
    while((t = yylex()) != FDT){
        mostrarToken(t);
    }
    mostrarToken(t);
}