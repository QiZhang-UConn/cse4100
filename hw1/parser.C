#include "parser.H"
#include "grammar.h"
#include <iostream>
#include <iomanip>

Parser::Parser() {}
Parser::~Parser() {}

using namespace std;
void Parser::run(const char* fn)
{
   extern int yyparse(Parser*);
   extern int yylex(YYSTYPE* yylv);
   extern FILE* yyin;
   extern int yydebug;
   //yydebug = 1;
   
   YYSTYPE val;
   int tok;
   // Write your driver here!
   // We expect you to call yylex to get tokens.
   // Recall that yylex expects, as input, a pointer to a value
   // of type YYSTYPE that would contain the lexeme.
   // YYSTYPE is the type of the union declared in the grammar file. 
   // For instance, val.val would be of type int while val.id would be
   // of type char*.
   tok = yylex(&val);
   std::cout<<"This is token"<< tok << val.id <<  endl;

   tok = yylex(&val);
   std::cout<<"This is token"<<tok<<val.val<<end;
   
}

extern "C" int yywrap()
{  /* This is to _chain_ scanning several files */
   return 1;
}

int yyerror(Parser* p,const char* s)
{
   std::cerr << s << std::endl;
   return 0;
}


