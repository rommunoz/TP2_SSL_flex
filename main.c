#include <stdio.h>
#include <ctype.h>
#include "scanner.h"
#include "tokens.h"

char* vecNombres[DIM_TOKENS] = {"Fin de Texto", "Identificador", "Numero", 
        "-=", "+=", "*=", "/=", "Palabra reservada var", "Palabra reservada salir",
        "NL", "Cadena desconocida", "Nro invalido", "Identificador invalido"};

void mostrarToken(int token){
    if(token < DIM_TOKENS && yyleng < DIM_BUFF-1){
        printf("Token: %s\t%s\n", vecNombres[token], lex_buf);
    }
}

int main(void){
    while(token != FDT){
        token = yylex();
        mostrarToken(token);
    }
}