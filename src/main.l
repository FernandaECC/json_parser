
%{
//Fernanda Chaves 215835
#include <stdlib.h>
void yyerror(char *c);

#include "y.tab.h"

%}

STR [A-Za-z]+
NUMERO [0-9]+



%%

{STR}				          {yylval.rotulo = yytext[0]; return PALAVRA;}
{STR}({NUMERO})+		  {yylval.rotulo = yytext[0]; return PALAVRA_NUM;}
{STR}([\ ]+{STR})+	  {yylval.rotulo = yytext[0]; return FRASE;}
{STR}([\ ]+{NUMERO})+	{yylval.rotulo = yytext[0]; return FRASE_NUM;}
{NUMERO}\.{NUMERO}		{yylval.valorF = atof(yytext); return FLOAT;}
{NUMERO}			        {yylval.valorI = atoi(yytext); return INTEIRO;}
\{				            return INICIO_OBJ;
\}				            return FIM_OBJ;
\n				            return FIM_LINHA;
\"				            return ASPAS;
\:				            return DOIS_PONTOS;
\[				            return INICIO_VETOR;
\]				            return FIM_VETOR;
\,				            return VIRGULA;
\0				            return NULO;
. ;


%%

int yywrap() {
  return 1;
}
