    include <ctype.h>
    include <stdio.h>

//puede servir
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
fueraDelAlfabeto [^0-9a-zA-Z.()=*+/-] //intento, pero creo que está mal

//tokens, fdt automatico, TODO: palabrasReservadas se usa ECHO?
identificador {idVariable}|{idFuncion}
numero {flotante}|{entero}
menosIgual -= //se puede "+=" ?
masIgual \+=
porIgual \*=
divIgual \/=
palResVar var 
palResSalida salir
nuevaLinea \n
cadenaDesconocida {fueraDelAlfabeto}.* //TODO:capaz sacar .Kleene esta bien hacer asi la negacion de mi alfabeto??? con 1 car fuera basta para que matchee y desp acepta hasta un \n o \r, tengo mi duda y es que reconocería a@+3 como un error todo junto
idInvalido {identificador}{cadenaDesconocida}
literalInvalido {numero}({letra}+|[.]({digito}*[.]+{digito}*)+)  // {numero}({letra}+|[.]{2,}) // [.]{2,} si serian dos puntos seguidos, yo le intercalé unos digitos optativos entre medio, porque si intercalo cualquier cosa me puede dar un char fuera de mi alfabeto

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput

%%

{palResVar} {           return PR_VAR;          }
{palResSalida} {        return PR_SALIR;        }
{identificador} {       return IDENTIFICADOR;   }
\n {                    return NL;              }
{numero} {              return NUMERO;          }
{menosIgual} {          return OP_MENOS_IG;     } 
{masIgual} {            return OP_MAS_IG;       }
{porIgual} {            return OP_POR_IG;       }
{divIgual} {            return OP_DIV_IG;       }
{cadenaDesconocida} {   return CAD_DESCONOCIDA; }
{idInvalido} {          return ID_INVALIDO;     }
{literalInvalido} {     return NUM_INVALIDO;    }