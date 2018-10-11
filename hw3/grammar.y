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

%defines
%pure-parser
%parse-param { Parser* parser }
%expect 0  // we can deal with 1 shift-reduce (dangling else). At first, start at 0. When adding if-then-else, increase to 1.

 // Define all your tokens
 // Give them a lexeme when appropriate (from HW1)
 // Deal with operator precedence and associativity

%token <val> NUMBER TRUE FALSE
%token <id>  TID THIS
%token <smb> TIF TELSE TEQ NEQ LEQ GEQ TAND TOR TNEW  TINT TBOOL TVOID TDB
%token <smb> TRETURN TWHILE TCLASS TEXTENDS 


 
 // Fill in!

%%

 // Define your grammar below
 // I give you the first rule of the grammar. 
 // It has one action to report (via a method call on the parser)
 // that the parsing was successful. See parser.C
 // Clearly we have:
 // 1. Top is the start symbol of the grammar
 // 2. Statement is a non-terminal
 // 3. The code in the curly brace block runs at the end and reports success. 
 // 4. You are missing /lots/ of non-terminal. Read the PDF handout!

Top: Statement { parser->success(); }
;

Statement: 
;

// Fill in!


%%
