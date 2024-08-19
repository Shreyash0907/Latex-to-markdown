#ifndef Node_hpp
#define Node_hpp

#include <iostream>
#include <memory>
#include <vector>

// enum symbol {
//     LCURB,
//     RCURB,
//     OTHER,
//     APER,
//     TAB,
//     BSLASH,
//     PIPE,
//     NEWLINE,
//     LSQRB,
//     RSQRB,
//     TEXT,
//     SPACE,
//     ITALIC,
//     BOLD,
//     HREF,
//     GRAPHIC,
//     HRULE,
//     SECTION,
//     PARAGRAPH,
//     ITEM,
//     SUBSECTION,
//     SUBSUBSECTION,
//     HLINE,
//     BCBLOCK,
//     ECBLOCK,
//     BOLIST,
//     EOLIST,
//     BUNOLIST,
//     EUNOLIST,
//     BTABLE,
//     ETABLE,
//     BDOC,
//     EDOC,
//     operations,
//     unoitem,
//     gsentence,
//     gsentences,
//     oitem,
//     gdata,
//     sentence,
//     sentences,
//     ospace,
//     ospaces,
//     tcontent,
//     tstructure,
//     tline, 
//     tlines,
//     lsentences,
//     symbols,
//     list,
//     codecontent,
//     start,
//     program,
//     blocks,
//     operationList,
//     ostatement,
//     thead,
//     url
// };

class Node{
    private: 
        std::string* value ;
        int type;
        std::vector< Node > productions;

    public:
        int getType(){
            return type;
        }

        Node(int val) : type(val) {}
};


#endif