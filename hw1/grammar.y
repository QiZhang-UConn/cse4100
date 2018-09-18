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
%token TIF

%left TOR 
%left TAND
%left '<' '>' 

%%

Top:
;
%%

