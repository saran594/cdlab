
%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
int yyerror();
%}

%token TYPE IDEN NUM INCR DECR RETURN

%left '+' '-'
%left '*' '/'

%start S

%%

S: FUN { printf("Accepted\n"); exit(0); } ;

FUN: TYPE IDEN '(' PARAMS ')' BODY ;

PARAMS: PARAM ',' PARAMS
      | PARAM
      | /* empty */
      ;

PARAM: TYPE IDEN ;

BODY: '{' STMTS '}'
    | STMT
    ;

STMTS: STMT
     | STMTS STMT
     ;

STMT: IDEN '=' EXPR ';'
    | IDEN INCR ';'
    | INCR IDEN ';'
    | IDEN DECR ';'
    | DECR IDEN ';'
    | RETURN EXPR ';'
    | DECLARATION ';'
    | ';'
    | '{' STMTS '}'
    ;

DECLARATION: TYPE IDEN
           | TYPE IDEN '=' EXPR
           ;

TYPE: IDEN ;

EXPR: EXPR '+' EXPR
    | EXPR '-' EXPR
    | EXPR '*' EXPR
    | EXPR '/' EXPR
    | IDEN
    | NUM
    ;

%%

int main() {
    printf("Enter function definition:\n");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("ERROR: %s\n", s);
    exit(1);
}