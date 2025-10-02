#include <iostream>
#include <sstream>

#ifdef _MSC_VER 
#define YY_NO_UNISTD_H
#include <io.h>
#endif

#include "gen/parser.h"
#include "gen/scanner.h"

void flexTest(std::string string) {
    yy_scan_string(string.c_str());

	int	token;

	while((token=yylex()) != 0){
		switch(token){
            break; case ASSIGN: std::cout << "=" << std::endl;
            break; case INCREMENT: std::cout << "++" << std::endl;
            break; case DECREMENT: std::cout << "--" << std::endl;
			break; case PLUS: std::cout << "+" << std::endl;
			break; case MINUS: std::cout << "-" << std::endl;
			break; case MULT: std::cout << "*" << std::endl;
			break; case DIV: std::cout << "/" << std::endl;
			break; case SEMI: std::cout << ";" << std::endl;
			break; case OPEN: std::cout << "(" << std::endl;
			break; case CLOSE: std::cout << ")" << std::endl;
			break; case NUMBER: std::cout << yylval.dval << std::endl;
            break; case IDENTIFIER: std::cout << yylval.sval << std::endl;
			break; default: std::cout << "!ERROR!" << std::endl;
		}
	}
}

void bisonTest(std::string string) {
	yy_scan_string(string.c_str());
	yyparse();
}


int main() {
	// flexTest("2 + 2; 4 / 2; 5 - 6;");
    
	bisonTest("2 + 2; 4 / 2; 5 - 6;");
	bisonTest("4 / 67;");
    bisonTest("a = 5; b = a++; c = b * 2; c--;");
    bisonTest("x = 10; y = x--; z = y / 2; z++;");
    bisonTest("m = 3; n = m++; p = n + 4; p--;");
    bisonTest("val = 7; val++; val = val * 2; val--;");
    bisonTest("count = 1; count++; count = count + 5; count--;");
    bisonTest("num = 8; num--; num = num - 3; num++;");
    bisonTest("total = 0; total++; total = total + 10; total--;");
    bisonTest("index = 4; index--; index = index * 3; index++;");
    bisonTest("score = 15; score++; score = score / 3; score--;");
    bisonTest("level = 2; level--; level = level + 6; level++;");
	// std::cout << "Hello World" << std::endl;
}
