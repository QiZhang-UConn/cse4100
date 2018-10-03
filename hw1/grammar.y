%{
#include <math.h>
#include <stdlib.h>
#include <list>
#include "parser.H"
#include <string.h>
#define YYERROR_VERBOSE   
%}

%union {
   int        val;
   char*      id;
}

%code{
   int yyerror(Parser* p,const char* s);
   int yylex(YYSTYPE*);
}

%pure-parser
%parse-param { Parser* parser }



%token <val> NUMBER TRUE FALSE 
%token <id>  TID
%token TIF TTHEN
%token LRB RRB
%token LBRAC RBRAC
%token LCBRAC RCBRAC
%token TWHILE
%token TELSE
%token LEQ
%token TDIV
%token SCOL
%token COM
%token TADD
%token GEQ
%token COMP
%token NEQ

%left TOR 
%left TAND
%left '<' '>' 

%%

Top:
   | input line
   ;




;
%%

yyerror(char *message)
{
  printf("%s\n",message);
}

int main(int argc, char* argv[])
{
  yyparse();
  return(0);
}
