
/*scanner of c--*/

%{
   #include <iostream>
   #include <iomanip>
   #include "parser.H"
   #include "grammar.h"
%}

DIGIT        [0-9]
ID           [a-zA-Z][a-zA-Z0-9]*
NUMBER       {DIGIT}+("."{DIGIT}*)?
%%

{NUMBER}    {
  yylval->val=atof(yytext);
  return NUMBER;
		    }
\.                  {return DOT;}
\;                  {return SCOL;}
\,                  {return COM;}
\(                  {return LRB;}
\)                  {return RRB;}
\+                  {return TADD;}
\-                  {return TSUB;}
\*                  {return TTIMES;}
\/                  {return TDIV;}
\<=                 {return LEQ;}
\>=                 {return GEQ;}
\==                 {return COMP;}
\!=                 {return NEQ;}
\<                  {return LESS;}
\>                  {return GREATER;}
\&&                 {return TAND;}
\||                 {return TOR;}
\=                  {return TEQ;}  
\!                  {return TNOT;}
\[                  {return LBRAC;}
\]                  {return RBRAC;}
\{                  {return LCBRAC;}
\}                  {return RCBRAC;}
while               {return TWHILE;}
if                  {return TIF;}
else                {return TELSE;}
this                {return TTHIS;}
class               {return CLASS;}
extends             {return EXTENDS;}
new                 {return NEW;}
return              {return RETURN;}
bool                {return TBOOL;}
int                 {return INT;}
void                {return VOID;}



{ID} {
  yylval->id=strdup(yytex);
  return TID;
}


[\t\n]*;
