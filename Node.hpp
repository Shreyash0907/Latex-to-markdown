#ifndef Node_hpp
#define Node_hpp

#include <iostream>
#include <memory>
#include <vector>

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
    Empty
};

class Node{
    private: 
        std::string* value ;
        symbol type;
        
        
    public:
        std::vector< Node* > productions;
        int depth;
        symbol getType(){
            return type;
        }

        void setValue(std::string* val){
            value = val;
        }
        std::string* getValue(){
            return value;
        }

        Node(symbol val) : type(val) {}

        void convert2Markdown();
};


#endif