%{
    #include<stdio.h>
    int single=0, multi=0, mlines=0;
    FILE *commentFile;
    // Removes all C Comments
%}
%%
"//"[^\n]*    { single++; fprintf(commentFile, "%s\n", yytext); }
"/*"([^*]|[*]+[^*/]|[*]*)*"*/" {
    multi++;
    for(int i=0; i<yyleng; i++) {
        if(yytext[i]=='\n')
            mlines++;
    }
    fprintf(commentFile, "%s\n", yytext);
}
. { fprintf(yyout, "%s", yytext); }
%%
int yywrap()
{
    return 1;
}
int main()
{
    // yyin = stdin by default; input file is passed via redirection
    yyout = fopen("3aout.txt", "w");
    commentFile = fopen("3acomments.txt", "w");
    yylex();
    printf("Single: %d\nMulti: %d\nMlines: %d\n", single, multi, mlines);
    return 0;
}