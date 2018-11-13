%{
#include <math.h>
#include <stdlib.h>
#include <list>
#include "parser.H"
#include "ast.H"
#include "ast.C"
#include <string.h>
#define YYERROR_VERBOSE   
%}

%union {
   int        val;
   char*      id;
  AST::Program* program;
  AST::Class*  cls;
  AST::Expr* expr;
  AST::Stmt* stmt;
  AST::Type* type;
  AST::Decl* decl;
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

%type <program> ClassList
%type <cls> ClassDecl
%type <stmt> Stmt
%type <decl> Decl
%type <expr> Expr
%type <type> Type

%%

 // You need to modify this rule to comply with the handout and pass new AST::Program($1) once you
 // have correctly implemented the actions in ClassList.

Top: ClassList { parser->saveRoot(new AST::Program($1));}
;

ClassList: ClassDecl ClassList 
| {}
;

ClassDecl: TCLASS TID '{' DeclList '}' ';' 
| TCLASS TID TEXTENDS TID '{' DeclList '}' ';'
;

DeclList : Decl DeclList   
|                          
;

Decl : Type TID ';'                                
|  Type TID '(' Formals ')' '{' StatementList '}'  
|       TID '(' Formals ')' '{' StatementList '}'  
;

Formals: OneOrMoreFormals 
| 
;

OneOrMoreFormals: Formal 
|  Formal ',' OneOrMoreFormals 
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

Expr: Expr '+' Expr   {$$ =new AST::Add($1,$3);}
| Expr '-' Expr       {$$ =new AST::Sub($1,$3);}
| Expr '*' Expr       {$$ =new AST::Mul($1,$3);}
| Expr '/' Expr       {$$ =new AST::Div($1,$3);}
| NUMBER              {$$ =new AST::Number($1);}
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
