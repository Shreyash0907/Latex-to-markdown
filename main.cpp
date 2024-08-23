#include <cstdio>
#include <iostream>
#include "parser.tab.hpp"
#include "lex.yy.hpp"
using namespace std;

extern int yylex(void);
extern int yyparse(void);
extern Node* getRoot();
extern int yydebug;

int main(int argc, char* argv[]){
    yydebug = 1;

    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
        return 1;
    }

    
    const char* inputFile = argv[1];
    const char* outputFile = argv[2];

    FILE *inputPtr, *outputPtr;

    inputPtr = fopen(inputFile, "r");
    if (inputPtr == NULL) {
        cout<<"Error: Unable to open latex File\n.";
        return 0;
    }

    outputPtr = fopen(outputFile, "w");
  
    if (outputPtr == NULL) {
        cout<<"Error: Unable to open Markdown File\n.";
        return 0;
    }

    extern FILE *yyin;

    yyin = inputPtr;


    yyparse();

    Node* temp = getRoot();
    temp->convert2Markdown();

    printf("%s\n", temp->getValue()->c_str());
    fprintf(outputPtr,"%s\n", temp->getValue()->c_str());

    fclose(inputPtr);
    fclose(outputPtr);
    return 0;
}