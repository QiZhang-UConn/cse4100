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
%expect 1  // we can deal with 1 shift-reduce (dangling else)

%token <val> NUMBER TRUE FALSE 
%token <id>  TID THIS
%token <smb> TIF TELSE TEQ NEQ TAND TOR TNEW  TINT TBOOL TVOID TDB
%token <smb> TRETURN TWHILE TCLASS TEXTENDS 

%left TOR 
%left TAND
%left '<' '>'  LEQ GEQ
%left TEQ NEQ
%left '+' '-'
%left '*' '/'
%left '!'
%left '('
%left '['
%left '.'

%%

Top: ClassList { parser->success(); }
;

ClassList:Class
|Class ClassList
;

Class: TCLASS TID '{' DeclList'}'';'
|TCLASS TID TEXTENDS TID '{'DeclList'}'';'
;

DeclList:Decl DeclList
|
;

Decl: Type TID ';'
|Type TID '(' ')' '{'StatementList'}'
|Type TID '('Formals ')''{'StatementList'}'
|TID '(' ')''{'StatementList'}'
|TID '('Formals')''{'StatementList'}'
;



Formals: OneOrMoreFormal
;

OneOrMoreFormal:Formal
|Formal ',' OneOrMoreFormal
;

Formal: Type TID
;

StatementList: Statement StatementList
|
;

Statement: Expr ';'       
| Type TID ';'            
| LValue '=' Relation ';' 
| '{' StatementList '}'   
| TWHILE '(' Relation ')' Statement           
| TIF '(' Relation ')' Statement              
| TIF '(' Relation ')' Statement TELSE Statement
| TRETURN Relation ';'                         
| ';'                                          
;

Relation: Relation TAND Relation   
  | Relation TOR Relation          
  | '!' Relation                   
  | Expr '<' Expr                  
  | Expr '>' Expr                  
  | Expr LEQ Expr                  
  | Expr GEQ Expr                  
  | Expr TEQ Expr                  
  | Expr NEQ Expr                  
  | Expr                           
;

Expr: Expr '+' Expr   
| Expr '-' Expr       
| Expr '*' Expr       
| Expr '/' Expr       
| NUMBER              
| TRUE                
| FALSE               
| '-' Expr            
| LValue              
| TNEW TID '(' Actuals  ')'  
| TNEW Type '[' Expr  ']'    
| '(' Relation ')'           
;

LValue: TID                  
| LValue '(' Actuals ')'     
| LValue '.' TID             
| LValue '[' Expr ']'        
| THIS                       
;

Actuals: OneOrMoreActuals    
|                            
;

OneOrMoreActuals: Relation      
| Relation ',' OneOrMoreActuals 
;

BasicType: TINT  
| TBOOL          
| TVOID          
| TID            
;

Type: BasicType  
| BasicType TDB  
;

%%
