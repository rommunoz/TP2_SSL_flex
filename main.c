#include <stdio.h>
#include <ctype.h>
#include "scanner.h"
#include "tokens.h"
#define DIM_TOKENS 10

char* token_names[DIM_TOKENS] = {"", "Identificador", "Numero", "-=", "+=", "*=", 
                    "/=", "Palabra reservada var", "Palabra reservada salir", "NL"};

void mostrarToken(enum token t){
    if(t < DIM_TOKENS){
        printf("Token: %s\tLexema: %s\n", token_names[t], yytext);
    } else {
        printf("Token: %d\tLexema: %c\n", yytext[0], yytext[0]); //1ra idea para las por defecto, pero hay que revisarlo o sacarlo
    }
}

int main(void){
    enum token t;
    while((t = yylex()) != FDT){
        mostrarToken(t);
    }
}