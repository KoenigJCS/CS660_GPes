/* definitions */

%{
#include <string>
#include <iostream>
#include <map>
extern int yylex();
extern int yyparse();
void yyerror(const char* s);
std::map<char*, double> symtab;
%}

%union {
    double dval;
    char* sval;
}

%token <dval> NUMBER
%token <sval> IDENTIFIER
// %token ERROR
%token INCREMENT
%token DECREMENT
%token SEMI
%token PLUS
%token MINUS
%token MULT
%token DIV
%token OPEN
%token CLOSE
%token ASSIGN

%left PLUS MINUS
%left MULT DIV
%left INCREMENT DECREMENT

%type <dval> Goal Declaration Expr Term Value Factor

%start Goal

%% /* Rules */

/*
Goal  -> Declaration
Declaration -> name = Expr
    | -> Expr
Expr  -> Expr + Term
    | -> Expr - Term
    | -> Term
Term  -> Term * Value
    | -> Term / Value
    | -> Term % Value
    | -> Term ^ Value
    | -> Value
Value -> [numb|name]++
    | -> [numb|name]--
    | -> Factor
Factor-> (Declaration)
    | -> numb
    | -> name
*/

Goal: Declaration SEMI {
        std::cout << "Result: " << $1 << std::endl;
    }
    ;
Declaration: IDENTIFIER ASSIGN Expr {symtab[$1] = $3; $$ = $3;}
    | Expr
    ;
Expr: Expr PLUS Term {$$ = $1 + $3;}
    | Expr MINUS Term {$$ = $1 - $3;}
    | Term
    ;
Term: Term MULT Value {$$ = $1 * $3;}
    | Term DIV Value {$$ = $1 / $3;}
    | Value
    ;
Value: IDENTIFIER INCREMENT {symtab[$1] == symtab[$1]++; $$ = symtab[$1];}
    | IDENTIFIER DECREMENT {symtab[$1] == symtab[$1]--; $$ = symtab[$1];}
    | NUMBER INCREMENT {$$ = $1++; }
    | NUMBER DECREMENT {$$ = $1--; }
    | Factor
    ;
Factor: OPEN Declaration CLOSE {$$ = $2;}
    | NUMBER {$$ = $1;}
    | IDENTIFIER {$$ = symtab[$1];}
;

%% /* Code */


void yyerror(char * s) {
	std::cerr << s << std::endl;
}