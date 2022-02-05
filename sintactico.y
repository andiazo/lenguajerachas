%{
#include <iostream>
using namespace std;
extern int yylex();
int yyerror(const char*);
%}

%token FUNCTION VARIABLE NUMBER FOR IF VAR LOGICAL_EXP COND_OP WHILE PRE_POST_FIX_OP
%start programSegment
%left '+' '-'
%left '*' '/'
%%

programSegment: command
 | programSegment command
;

command: decl ';'
 | exp ';'
 | ifCond
 | forLoop
 | whileLoop
 | assign ';'
 | functionDecl

ifCond: IF '(' cond ')' '{' programSegment '}'
;

forLoop: FOR '(' exp '=' exp ';' cond ';' VARIABLE PRE_POST_FIX_OP ')' '{' programSegment '}'
;

whileLoop: WHILE '(' cond ')' '{' programSegment '}'
;

functionDecl: FUNCTION VARIABLE '(' headerDecl ')' '{' programSegment '}'
;

headerDecl: VARIABLE ',' headerDecl
 | VARIABLE
;

decl: VAR VARIABLE
;

cond: exp COND_OP exp
 | exp
;

assign: VARIABLE '=' exp
;

exp: LOGICAL_EXP
   | NUMBER
   | VARIABLE
   | VARIABLE PRE_POST_FIX_OP
   | PRE_POST_FIX_OP VARIABLE
   | exp '+' exp
   | exp '-' exp
   | exp '*' exp
   | exp '/' exp
   | '(' exp ')'
;

%%

int main() {
	yyparse();
}

int yyerror(const char* s) {
    cout << s << endl;
}