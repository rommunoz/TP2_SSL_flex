%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"
%}
                      
exponente           [eE][-]?[0-9]+
flotante            ([0-9]+([.][0-9]*)|[.][0-9]+){exponente}?
letra               [a-zA-Z]
exponenteInvalido   [a-zA-Z]{-}[eE]|{letra}{letra}
fueraDelAlfabeto    [[:punct:]]{-}[0-9a-zA-Z.()^=*+/-]
realInvalido        \.*{flotante}({exponenteInvalido}|[.])[a-zA-Z0-9.]*
idInvalido          {letra}[a-zA-Z0-9]*{fueraDelAlfabeto}.*

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput
%option noyywrap
    //%option debug

%%

var                         return PR_VAR;
salir                       return PR_SALIR;
{letra}[a-zA-Z0-9]*         return IDENTIFICADOR;
\n                          return NL;
{flotante}|[0-9]+           return NUMERO;
-=                          return OP_MENOS_IG;
\+=                         return OP_MAS_IG;
\*=                         return OP_POR_IG;
\/=                         return OP_DIV_IG;
{idInvalido}                printf("Error léxico: Identificador inválido: '%s'\n", yytext);
[0-9]+{letra}[a-zA-Z0-9]*   printf("Error léxico: Constante inválida: '%s'\n", yytext);
{realInvalido}              printf("Error léxico: Real inválido: '%s'\n", yytext);
{fueraDelAlfabeto}+         printf("Error léxico: Cadena desconocida: '%s'\n", yytext);
[=^+/*()-]                  return yytext[0];
[ \t]                       //null;

%%