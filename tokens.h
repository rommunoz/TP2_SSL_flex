#ifndef tokens_h
#define tokens_h
#define e  2.7182818284
#define pi 3.1415926536
#define DIM_TOKENS 13
#define DIM_BUFF 512

enum enumToken {FDT = 0, IDENTIFICADOR, NUMERO, OP_MENOS_IG, OP_MAS_IG, OP_POR_IG, OP_DIV_IG,
            PR_VAR, PR_SALIR, NL, CAD_DESCONOCIDA, NUM_INVALIDO, ID_INVALIDO};

int token;

char lex_buf[DIM_BUFF];

char *vecNombres[DIM_TOKENS];

#endif
