#ifndef tokens_h
#define tokens_h 
#define e  2.7182818284
#define pi 3.1415926536

//17 tokens, podría ahorrarme 7
enum token {FDT, IDENTIFICADOR, NUMERO, PR_VAR, NL, OP_MENOS_IG, OP_MAS_IG, OP_POR_IG, OP_DIV_IG, 
            PTESIS_ABRE = 40, PTESIS_CIERRA, OP_POR, OP_MAS, OP_MENOS = 45, OP_DIV = 47, 
            OP_IG = 61, OP_EXP = 94}; 

#endif 