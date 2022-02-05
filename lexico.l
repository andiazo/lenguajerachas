%{

#undef yywrap
#define yywrap() 1 
#include <stdio.h>
#include <string.h>

void imprimir(char *valor, char *categoria);

%}

PALABRAS_RESERVADAS if|else|elif|while|for|def|return|model|bloque|tratamiento
DIGITO [0-9]
NUMERO ((\-)?{DIGITO}+(\.{DIGITO}+)?)
VARIABLE [a-zA-Z][a-zA-Z0-9]*
ESPACIO [" "]*
ARREGLO \[(({NUMERO}|{VARIABLE})\,{ESPACIO})*({NUMERO}|{VARIABLE})\]
MATRIZ \[(({ARREGLO})(\,{ESPACIO}{ARREGLO})+)\]
DELIMITADOR (\[|\]\(|\)|\{|\}|\,|\;)
COMENTARIO ((\/\*.*\*\/)|(\/\/.*))
OPERADOR_ASIGNACION =
OPERADOR_COMPARACION (<|>|<=|>=|==|!=)
OPERADOR_LOGICO (&&|\|\||\~)
OPERADOR_ARITMETICO (\+|\-|\*|\/|\%)

OPERACION_COMPARACION ({NUMERO}|{VARIABLE}){ESPACIO}{OPERADOR_COMPARACION}{ESPACIO}({NUMERO}|{VARIABLE})
OPERACION_LOGICA ({NUMERO}|{VARIABLE}){ESPACIO}{OPERADOR_LOGICO}{ESPACIO}({NUMERO}|{VARIABLE})
COMPARACION ({OPERACION_COMPARACION}|{OPERACION_LOGICA})

LLAMADA_FUNCION {VARIABLE}\((((({NUMERO}|{VARIABLE})),{ESPACIO})*(({NUMERO}|{VARIABLE})))?\)
FUNCION def{ESPACIO}{VARIABLE}\((({VARIABLE}{ESPACIO})*{VARIABLE})?\)

ASIGNACION {VARIABLE}{ESPACIO}={ESPACIO}({NUMERO}|{VARIABLE}|{ARREGLO}|{MATRIZ})
SELECCION ("if"{ESPACIO}\({COMPARACION}\))|("elif"{ESPACIO}\({COMPARACION}\))|("else"{ESPACIO})
ITERACION ("while"{ESPACIO}\({COMPARACION}\))

%%

{ITERACION} {
    imprimir(yytext,"ITERACION");
}

{SELECCION} {
    imprimir(yytext,"SELECCION");
}

{ASIGNACION} {
    imprimir(yytext,"ASIGNACION");
}

{FUNCION} {
    imprimir(yytext,"FUNCION");
}

{LLAMADA_FUNCION} {
    imprimir(yytext,"LLAMADA_FUNCION");
}

{OPERACION_LOGICA} {
    imprimir(yytext,"OPERACION_LOGICA");
}

{OPERACION_COMPARACION} {
    imprimir(yytext,"OPERACION_COMPARACION");
}


{ARREGLO} {
    imprimir(yytext,"ARREGLO");
}

{MATRIZ} {
    imprimir(yytext,"MATRIZ");
}

{NUMERO} {
    imprimir(yytext,"NUMERO");
} 

{PALABRAS_RESERVADAS} {
    imprimir(yytext,"PALABRAS_RESERVADAS");
}

{VARIABLE} {
    imprimir(yytext,"VARIABLE");
}

{DELIMITADOR} {
    imprimir(yytext,"DELIMITADOR");
}

{COMENTARIO} {
    imprimir(yytext,"COMENTARIO");
}


{OPERADOR_COMPARACION} {
    imprimir(yytext,"OPERADOR_COMPARACION");
}

{OPERADOR_ARITMETICO} {
    imprimir(yytext,"OPERADOR_ARITMETICO");
}

{OPERADOR_LOGICO} {
    imprimir(yytext,"OPERADOR_LOGICO");
}

{OPERADOR_ASIGNACION} {
    imprimir(yytext,"OPERADOR_ASIGNACION");
}

%%
 
int main()
{
  yyin = fopen("texto.txt","r");
  yylex();
  return 0;
}

void imprimir(char *valor, char *categoria)
{
    if(strcmp(valor, ";") == 1)
    {
        printf("\n");
    }
    printf( "( %s , %s ) ", valor, categoria );
}