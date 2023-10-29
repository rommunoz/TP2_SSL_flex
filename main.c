#include <stdio.h>
#include <ctype.h>
#include "scanner.h"
#include "tokens.h"
#define DIM_TOKENS 17

//el resto son caracteres o par de caracteres
char* token_names[DIM_TOKENS] = {"Fin de Archivo", "Identificador", "Numero"};

void mostrarToken(enum token t){
    if(t < DIM_TOKENS && t <= NUMERO){
        printf("Token: %s\tLexema: %s\n", token_names[t], yytext);
    } else {
        printf("Token: '%s'\t\n", yytext); //1ra idea para las por defecto, revisar
    }
}

int main(void){
    int t;
    while((t = yylex()) != FDT){
        mostrarToken(t);
    }
    mostrarToken(t);
}