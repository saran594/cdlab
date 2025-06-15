%{
#include <stdio.h>
int posint = 0, negint = 0, posfrac = 0, negfrac = 0, posdec = 0, negdec = 0;
%}

num     [0-9]+
dec     {num}\.[0-9]+
frac    {num}\/{num}

%%

\+?{num}              { posint++; }
-{num}                { negint++; }
\+?{dec}              { posdec++; }
-{dec}                { negdec++; }
\+?{frac}             { posfrac++; }
-{frac}               { negfrac++; }

[ \t]                 ;
\n                    { return 0; }
.                     { ECHO; }

%%

int yywrap(){ return 1; }

int main() {
    printf("enter ur numbers:");
    yylex();
    printf("Positive integers: %d\n", posint);
    printf("Negative integers: %d\n", negint);
    printf("Positive decimals: %d\n", posdec);
    printf("Negative decimals: %d\n", negdec);
    printf("Positive fractions: %d\n", posfrac);
    printf("Negative fractions: %d\n", negfrac);
}