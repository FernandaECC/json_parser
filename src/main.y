

%{
#include <stdio.h>
  #include <stdlib.h>
void yyerror(char *c);
int yylex(void);
%}

%union
{
  int valorI;
  float valorF;
  char rotulo;
};


%type <valorI> INTEIRO
%type <rotulo> FRASE
%type <rotulo> PALAVRA
%type <rotulo> FRASE_NUM
%type <rotulo> PALAVRA_NUM
%type <valorF> FLOAT

%token INICIO_OBJ FIM_OBJ FIM_LINHA FRASE FLOAT INTEIRO ASPAS DOIS_PONTOS INICIO_VETOR FIM_VETOR VIRGULA PALAVRA FRASE_NUM PALAVRA_NUM NULO


%%

verificacao: 
	objeto FIM_LINHA {printf("VALIDO\n");}
	| objeto FIM_LINHA FIM_LINHA {printf("VALIDO\n");}
	;

objeto:
	INICIO_OBJ dado FIM_OBJ {}
	| INICIO_OBJ sub_objeto FIM_OBJ {}
	| INICIO_OBJ sub_objeto FIM_LINHA FIM_OBJ {}
	| INICIO_OBJ dado FIM_LINHA FIM_OBJ {}
	;

sub_objeto:
	elemento DOIS_PONTOS INICIO_OBJ dado FIM_OBJ {}
	| elemento DOIS_PONTOS INICIO_OBJ FIM_LINHA dado FIM_LINHA FIM_OBJ {}
	| elemento DOIS_PONTOS INICIO_OBJ sub_objeto FIM_OBJ {}
	;

dado:
	vetor {}
	| elemento DOIS_PONTOS vetor {}
	| elemento DOIS_PONTOS elemento {}
	| dado VIRGULA dado {}
	| dado VIRGULA FIM_LINHA dado {}
	;

vetor:
	INICIO_VETOR elem_vetor FIM_VETOR {}
	| INICIO_VETOR FIM_VETOR {}
	| INICIO_VETOR elem_vetor VIRGULA vetor FIM_VETOR {}
	| INICIO_VETOR vetor FIM_VETOR {}
	;

elem_vetor:
	elemento {}
	| elemento VIRGULA elem_vetor {}
	;
	

elemento:
	ASPAS FRASE ASPAS {}
	|ASPAS PALAVRA ASPAS {}
	|ASPAS FRASE_NUM ASPAS {}
	|ASPAS PALAVRA_NUM ASPAS {}
	| INTEIRO {}
	| FLOAT {}
	;




%%

void yyerror(char *s) {
	printf("INVALIDO\n");
}

int main() {
  yyparse();
    return 0;

}
