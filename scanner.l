    #include <ctype.h>
    #include <stdio.h>
    #include <string.h>
    #include "tokens.h"

operadorAsign =[+/*-]?
operador {operadorArit}|{operadorAsign} 

digito [0-9]
entero [+-]?{digito}+
exponente [eE]{entero}
flotante [+-]?({digito}+([.]{digito}*)?|[.]{digito}+){exponente}?

letra [a-zA-z]
letrasSinE [a-zA-z]{-}[eE]
idVariable {letra}({letra}|{digito})*
idFuncion a?(sin|cos|tan)|sqrt|log
fueraDelAlfabeto [^0-9a-zA-Z.()=*+/-]{-}[ \n\t]

identificador {idVariable}|{idFuncion}
numero {flotante}|{entero}
menosIgual -=
masIgual \+=
porIgual \*=
divIgual \/=
palResVar var
palResSalida salir
nuevaLinea \n
cadenaDesconocida {fueraDelAlfabeto}.*
idInvalido {identificador}{cadenaDesconocida}
literalInvalido {numero}({letra}+|[.]({digito}*[.]+{digito}*)+)

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput

%%

{palResVar} {           return PR_VAR;}
{palResSalida} {        return PR_SALIR;}
{identificador} {       strcpy(lex_buf, yytext); return IDENTIFICADOR;}
\n {                    return NL;}
{numero} {              strcpy(lex_buf, yytext); return NUMERO;}
{menosIgual} {          return OP_MENOS_IG;} 
{masIgual} {            return OP_MAS_IG;}
{porIgual} {            return OP_POR_IG;}
{divIgual} {            return OP_DIV_IG;}
{cadenaDesconocida} {   strcpy(lex_buf, yytext); return CAD_DESCONOCIDA;}
{idInvalido} {          strcpy(lex_buf, yytext); return ID_INVALIDO;}
{literalInvalido} {     strcpy(lex_buf, yytext); return NUM_INVALIDO;}

%%