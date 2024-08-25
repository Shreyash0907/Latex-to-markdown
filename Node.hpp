/**
 * @file Node.hpp
 * @author Shreyash Chikte (shreyashsc9@gmail.com)
 * @brief Class defination for the structure of the Node in AST.
 * 
 * Defines the enum for the type of node in AST
 * @version 0.1
 * @date 2024-08-24
 * 
 * @copyright Copyright (c) 2024
 * 
 */
#ifndef Node_hpp
#define Node_hpp

#include <iostream>
#include <memory>
#include <vector>
#include <cstdio>
#include <iostream>
#include <fstream>
/// @brief Denotes the type of the node in AST.
enum symbol {
    Operations,
    Unoitem,
    Gsentence,
    Gsentences,
    Oitem,
    Gdata,
    Sentence,
    Sentences,
    Ospace,
    Ospaces,
    Tcontent,
    Tstructure,
    Tline,
    Tlines,
    Lsentences,
    Symbols,
    List,
    Codecontent,
    Start,
    Program,
    Blocks,
    Operationlist,
    Ostatement,
    Table,
    Thead,
    Url,
    Text,
    Space,
    Newline,
    Italic,
    Bold,
    Section,
    Subsection,
    Subsubsection,
    Href,
    Hrule,
    Graphic,
    Paragraph,
    Lcurb,
    Rcurb,
    Lsqrb,
    Rsqrb,
    Aper,
    Pipe,
    Bslash,
    Code,
    Empty,
    Hline,
    Dmath,
    Sout,
    Imath,
};


std::string getEnumValue(symbol type);
/**
 * @brief Represents a structure of the node in the AST.
 * 
 * It has different variables and member function in them.
 */
class Node{
    private: 
        /// @brief Stores the value of the particular node.
        std::string* value ;
        /// @brief Stores the type of the Node of type symbols
        symbol type;
        
        
    public:
        /// @brief Stores the children productions for a partiular node.
        std::vector< Node* > productions;

        /// @brief Stores the structure of the table columns.
        std::vector<std::string> tstruct;

        /// @brief In case of nested lists, the depth of the particular list is stored.
        int depth;

        /// @brief Denotes the row number of the table. used when converting to markdown.
        int rownum;

        /// @brief Used to access the private vaiable value.
        /// @return Returns the type of the Node.
        symbol getType(){
            return type;
        }

        /// @brief Used to set the value of the private variable val
        /// @param val value to be store as the Node's value
        void setValue(std::string* val){
            value = val;
        }

        /// @brief Used as getter funtion for value variable
        /// @return Returns the Node's value
        std::string* getValue(){
            return value;
        }
        /// @brief Constructor for the Node.
        /// @param val Value with which the Node is initialize.
        Node(symbol val) : type(val) {};

        /// @brief To convert the Node's value to markdown.
        void convert2Markdown();

        void printAST(Node* node, int depth, std::ofstream& astPointer);
};


#endif