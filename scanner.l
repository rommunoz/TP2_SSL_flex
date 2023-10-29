    #include <ctype.h>
    #include <stdio.h>
    #include <string.h>
    #include "tokens.h"

entero [+-]?{[0-9]}+
exponente [eE]{entero}
flotante [+-]?({[0-9]}+([.]{[0-9]}*)?|[.]{[0-9]}+){exponente}?

letra [a-zA-z]
letrasSinE [a-zA-z]{-}[eE]
idVariable {letra}({letra}|{[0-9]})*
idFuncion a?(sin|cos|tan)|sqrt|log
fueraDelAlfabeto [^0-9a-zA-Z.()=*+/-]{-}[ \n\t]

identificador {idVariable}|{idFuncion}
menosIgual -=
masIgual \+=
porIgual \*=
divIgual \/=
palResVar var
palResSalida salir
cadenaDesconocida {fueraDelAlfabeto}.*
literalInvalido {numero}({letra}+|[.]({[0-9]}*[.]+{[0-9]}*)+)

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput

%%

var {                                   return PR_VAR;}
salir {                                 return PR_SALIR;}
{identificador} {                       strcpy(lex_buf, yytext); return IDENTIFICADOR;}
\n {                                    return NL;}
{flotante}|{entero} {                   strcpy(lex_buf, yytext); return NUMERO;}
{menosIgual} {                          return OP_MENOS_IG;} 
{masIgual} {                            return OP_MAS_IG;}
{porIgual} {                            return OP_POR_IG;}
{divIgual} {                            return OP_DIV_IG;}
{cadenaDesconocida} {                   strcpy(lex_buf, yytext); return CAD_DESCONOCIDA;}
{identificador}{cadenaDesconocida}  {   strcpy(lex_buf, yytext); return ID_INVALIDO;}
{literalInvalido} {                     strcpy(lex_buf, yytext); return NUM_INVALIDO;}

%%