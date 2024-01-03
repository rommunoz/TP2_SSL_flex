#include <stdio.h>
#include "tokens.h"
#include "scanner.h"
#define DIM_TOKENS 6

//el resto son caracteres o par de caracteres
char* token_names[DIM_TOKENS] = {"Fin de Archivo", "var", "salir", "'NL'", "Identificador", "Numero"};

void mostrarToken(enum token t){
    if (t < DIM_TOKENS){
        printf("Token: %s", token_names[t]);
        if (t >= IDENTIFICADOR){
            printf("\tlexema: %s\n", yytext);
        } else {
            printf("\n");
        }
    } else {
        printf("Token: '%s'\n", yytext);
    }
}

int main(void){
    int t;
    while((t = yylex()) != FDT){
        mostrarToken(t);
    }
    mostrarToken(t);
}