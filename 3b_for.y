%{
#include <stdio.h>
#include <stdlib.h>

int total_for_count = 0;
int current_nesting = 0;
int max_nesting = 0;

int yylex();
int yyerror(const char *s);
%}

%token FOR IDEN NUM OP INCR DECR RETURN

%%

STMTS: STMT
     | STMTS STMT
     ;

STMT: FORSTMT
    | IDEN '=' EXPR ';'
    | IDEN INCR ';'
    | INCR IDEN ';'
    | IDEN DECR ';'
    | DECR IDEN ';'
    | DECLARATION ';'
    | ';'
    | '{' STMTS '}'
    ;

FORSTMT: FOR '(' OPTIONAL_ASSGN ';' COND ';' OPTIONAL_ASSGN ')'
        {
            total_for_count++;
            current_nesting++;
            if (current_nesting > max_nesting)
                max_nesting = current_nesting;
        }
        STMT
        {
            current_nesting--;
        }
        ;

OPTIONAL_ASSGN: ASSGN | /* empty */ ;

ASSGN: IDEN '=' EXPR
     | IDEN INCR
     | IDEN DECR
     | INCR IDEN
     | DECR IDEN
     | IDEN
     ;

COND: IDEN OP IDEN
     | IDEN OP NUM
     | IDEN
     | NUM
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
    printf("Enter the code snippet (Ctrl+D to end):\n");
    yyparse();
    printf("\nTotal FOR loops: %d\n", total_for_count);
    printf("Maximum nesting level: %d\n", max_nesting);
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}
