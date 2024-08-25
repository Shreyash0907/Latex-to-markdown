/**
 * @file main.cpp
 * @author Shreyash Chikte
 * @brief Main function in the project.
 * @version 0.1
 * @date 2024-08-24
 * 
 * @copyright Copyright (c) 2024
 * 
 */
#include <cstdio>
#include <iostream>
#include "parser.tab.hpp"
#include "lex.yy.hpp"
#include <fstream>
using namespace std;

/// @brief Function used to create the token from input file. 
extern int yylex(void);

/// @brief Function used to parse the input token and creates the AST.
extern int yyparse(void);

/// @brief Function returns the root Node of the AST after the completion of parsing.
/// @return Object of Node.
extern Node* getRoot();

/// @brief Used to debug the parsing process.
extern int yydebug;

/// @brief Main function in the project.
/// @param argc Denotes the count of the arguments.
/// @param argv Stores the arguments in the array.
/// @return Returns integer value.
int main(int argc, char* argv[]){
    // yydebug = 1;
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
        return 1;
    }

    /// This denotes the input File name
    const char* inputFile = argv[1];
    /// Denotes the Output file name
    const char* outputFile = argv[2];


    FILE *inputPtr, *outputPtr, *astPointer;

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

    Node* root = getRoot();
    root->convert2Markdown();

    fprintf(outputPtr,"%s\n", root->getValue()->c_str());

    std::ofstream astFile("../printedAST.txt");
    
    root->printAST(root, 0, astFile);
    fclose(inputPtr);
    fclose(outputPtr);
    return 0;
}