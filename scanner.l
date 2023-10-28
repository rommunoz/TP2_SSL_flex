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

//Pendiente 
//TODO: DUDA: esta bien hacer asi la negacion de mi alfabeto??? con 1 car fuera basta para que matchee y desp acepta hasta un \n o \r
//TODO: DUDA: los operadores unarios debo ver como devuelvo cuando van pegados. Devuelvo espacios? en las declaraciones necesita espacios.
//TODO: DUDA: los parentesis dejo que se manden como un token mas por ser caracteres?
//TODO: DUDA: \n se devuelve solo?
//TODO: DUDA: palabraReservadaVar, ... // así? o id con lexema y que se arregle despues?
//TODO: DUDA: operadores hago un token para cada uno o dejo que vayan solos como caracteres? esta el tema de que sea aceptor el estado y bla bla. A demas hay una combinacion con el igual

//TODO: NOTAS: hacer un top down: 
    cuantos tokens devuelvo a mano: 
        identificador y su lexema, 
        numero y su literal (se arma un float con o sin exponente y enteros)                // despues se lo implementa como double pero no me interesa)
        palabraReservadaSalir, 
        palabraReservadaVar, ... // así? o id con lexema y que se arregle despues?
        operadores uno por uno o dejo que vayan solos?
    y cuantos automatico:
        // espacios ignorados en main o en el mismo yylex
        // que onda las varPredef pi|e, lo hice en el .h
        EOF
        caracteres sueltos
        \n                        //?
        caracterPuntuacion [{()}] //?



