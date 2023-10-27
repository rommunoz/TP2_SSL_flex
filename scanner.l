digito [0-9]
entero [+-]?{digito}+
exponente [eE]{entero}
flotante [+-]?({digito}+([.]{digito}*)?|[.]{digito}+){exponente}?
operadorArit [+^/*-]
operadorAsign =[+/*-]?
caracter [^\n\r]
nuevaLinea \n
varPredef pi|e
letra [a-zA-z]
idVariable {letra}({letra}|{digito})*
idFuncion a?(sin|cos|tan)|sqrt|log
palabraReservada var salir
fueraDelAlfabeto [^0-9a-zA-Z.()=*+/-] //intento, pero creo que está mal

cadenaDesconocida {fueraDelAlfabeto}.* //TODO: esta bien hacer asi la negacion de mi alfabeto??? con 1 car fuera basta para que matchee y desp acepta hasta un \n o \r
idInvalido {identificador}{cadenaDesconocida}
literalInvalido {numero}+({letra}+|[.]({digito}*[.]+{digito}*)+)  // {numero}+({letra}+|[.]{2,}) // [.]{2,} si serian dos puntos seguidos, yo le intercalé unos digitos optativos entre medio, porque si intercalo cualquier cosa me puede dar un char fuera de mi alfabeto

identificador {idVariable}|{idFuncion}
numero {flotante}|{entero}|{varPredef}
operador {operadorArit}|{operadorAsign} //creo que no se usa

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput %option nounput

%%

