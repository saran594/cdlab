%{
    #include<stdio.h>
    int lines=0, bp=0, words=0, chars=0;
%}
%%
[ ] bp++;
\t bp=bp+4;
\n lines++;
[^ \t\n#]+ {words++; chars+=yyleng;}
# {return 0;}
%%
int yywrap()
{
	return 1;
}
int main(){
    printf("Enter your string: ");
    yylex();
    printf("%d%d%d%d",lines,bp,words, chars );
    return 0;
}