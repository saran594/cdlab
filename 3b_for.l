%{
#include "y.tab.h"
%}

%%
"for"               return FOR;
">="|"<="|"=="|"!=" return OP;
">"|"<"             return OP;
"++"|"--"           return INCR;
[a-zA-Z_][a-zA-Z0-9_]* return IDEN;
[0-9]+              return NUM;
[ \t\r]+            ;           // Ignore whitespace
\n                  ;           // Ignore newlines
.                   return yytext[0]; // Return single characters like (, ), =, ;, etc.
%%

int yywrap() {
    return 1;
}
