%{
#include <stdio.h>
int id = 0, key = 0, op = 0;
%}

%%
"int"|"char"|"float"|"double"|"if"|"else"|"for"|"while"|"exit"|"return"    { key++; }
[a-zA-Z_][a-zA-Z0-9_]*                                                      { id++; }
"=="|"!="|"<="|">="                                                         { op++; }
[\+\-\*\/\%\^\&\|\!\=\<\>\:]                                                { op++; }
[ \t\n]+                                                                    ; // Ignore whitespace
.                                                                           ; // Ignore any other single character
%%

int main()
{
    printf("Enter:\n");
    yylex();
    printf("Identifiers: %d\nKeywords: %d\nOperators: %d\n", id, key, op);
    return 0;
}
int yywrap()
{
    return 1;
}