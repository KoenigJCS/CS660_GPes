/* Definitions */

%{
#include <iostream>
#include <cstdlib>
#include <ctype.h>
%}

%option noyywrap
%option c++


%% /* Actions */


[ \t\n\r] {return 0;}
"++" { return INCREMENT; }
"--" { return DECREMENT; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
"(" { return OPEN; }
")" { return CLOSE; }
";" { return SEMI; }
"=" { return ASSIGN; }
[a-zA-Z_][a-zA-Z0-9_]*  { 
    yylval.sval = yytext;
    return IDENTIFIER; 
}
[0-9]+|([0-9]+(\.[0-9]+)?(e[+-]?[0-9]+)?) { 
    yylval.dval = std::stod(yytext);
    return NUMBER; 
}
 /*. { return ERROR; }*/
. { return yytext[0]; } /* Returns whatever character is found (which won't match the parser, creating an error) */


%% /* code */
