/**
 * @file Node.cpp
 * @author Shreyash Chikte (shreyashsc9@gmail.com)
 * @brief Funcion implementation for class Node
 * @version 0.1
 * @date 2024-08-24
 * 
 * @copyright Copyright (c) 2024
 * 
 */
#include "Node.hpp"


/**
     * @brief Prints the Abstract syntax tree depth wise.
     * 
     * @param type The type of the node is passed.
     * @return Function doesn't return any value.
*/
std::string getEnumValue(symbol type){
    switch(type){

        case Operations :
            return "Operation_Node";
            break;
        case Unoitem:
            return "Unoitem_Node";
            break;
        case Gsentence:
            return "Gsentence_Node";
            break;
        case Gsentences:
            return "Gsentences_Node";
            break;
        case Oitem:
            return "Oitem_Node";
            break;
        case Gdata:
            return "Gdata_Node";
            break;
        case Sentence:
            return "Sentence_Node";
            break;
        case Sentences:
            return "Sentences_Node";
            break;
        case Ospace:
            return "Ospace_Node";
            break;
        case Ospaces:
            return "Ospaces_Node";
            break;
        case Tcontent:
            return "Tcontent_Node";
            break;
        case Tstructure:
            return "Tstructure_Node";
            break;
        case Tline:
            return "Tline_Node";
            break;
        case Tlines:
            return "Tlines_Node";
            break;
        case Lsentences:
            return "Lsentences_Node";
            break;
        case Symbols:
            return "Symbold_Node";
            break;
        case List:
            return "List_Node";
            break;
        case Codecontent:
            return "Codecontent_Node";
            break;
        case Start:
            return "Start_Node";
            break;
        case Program:
            return "Program_Node";
            break;
        case Blocks:
            return "Blocks_Node";
            break;
        case Operationlist:
            return "Operationlist_Node";
            break;
        case Ostatement:
            return "Ostatement_Node";
            break;
        case Table:
            return "Table_Node";
            break;
        case Thead:
            return "Thead";
            break;
        case Url:
            return "Url_Node";
            break;
        case Text:
            return "Text_Node";
            break;
        case Space:
            return "Space_Node";
            break;
        case Newline:
            return "Newline_Node";
            break;
        case Italic:
            return "Italic_Node";
            break;
        case Bold:
            return "Bold_Node";
            break;
        case Section:
            return "Section_Node";
            break;
        case Subsection:
            return "Subsection_Node";
            break;
        case Subsubsection:
            return "Subsubsection_Node";
            break;
        case Href:
            return "Href_Node";
            break;
        case Hrule:
            return "Hrule_Node";
            break;
        case Graphic:
            return "Graphic_Node";
            break;
        case Paragraph:
            return "Paragraph_Node";
            break;
        case Lcurb:
            return "Left curly bracket Node";
            break;
        case Rcurb:
            return "Right curly bracket Node";
            break;
        case Lsqrb:
            return "Left square bracket Node";
            break;
        case Rsqrb:
            return "Right square bracket Node";
            break;
        case Aper:
            return "Ampersand_Node";
            break;
        case Pipe:
            return "Pipe_Node";
            break;
        case Bslash:
            return "Back Slash Node";
            break;
        case Code:
            return "Code_Node";
            break;
        case Empty:
            return "Empty_Node";
            break;
        case Hline:
            return "Hline_Node";
            break;
        case Dmath:
            return "Display Math Node";
            break;
        case Sout:
            return "Strike Through Node";
            break;
        case Imath:
            return "Inline math Node";
            break;
        default:
            return "Unexpected_Node";
            break;
    }
}
/**
     * @brief Prints the Abstract syntax tree depth wise.
     * It converts the node value to markdown language.
     * It takes the type of the node as the value and based on that the conversion is done
     * 
     * @return Function doesn't return any value.
*/
void Node::convert2Markdown() {

    switch (this->type)
    {

    case Start:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Program:
        if(static_cast<int>(this->productions.size()) == 2){
            this->productions[0]->convert2Markdown();
            this->productions[1]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }
        break;
    
    case Text:
        this->setValue(this->value);
        break;
    
    case Space:
        this->setValue(this->value);
        break;
    
    case Newline:
        this->setValue(this->value);
        break;
    
    case Lcurb:
        this->setValue(new std::string("{"));
        break;
    
    case Rcurb:
        this->setValue(new std::string("}"));
        break;

    case Lsqrb:
        this->setValue(new std::string("["));
        break;

    case Rsqrb:
        this->setValue(new std::string("]"));
        break;
    
    case Pipe:
        this->setValue(new std::string("|"));
        break;

    case Aper:
        this->setValue(new std::string("&"));
        break;

    case Bslash:
        this->setValue(new std::string("\\"));
        break;

    case Paragraph:
        this->setValue(new std::string("\n"));
        break;
    
    case Graphic:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("![Image]("+ *(this->productions[0]->value) + ")" ));
        break;

    case Hrule:
        this->setValue(new std::string("\n----"));
        break;

    case Href:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        this->setValue(new std::string("[" + *(this->productions[1]->value) + "]" + "(" + *(this->productions[0]->value) + ")" ));
        break;
    
    case Subsubsection:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("### " + *(this->productions[0]->value)));
        break;

    case Subsection:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("## " + *(this->productions[0]->value)));
        break;
    
    case Section:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("# " + *(this->productions[0]->value)));
        break;
    
    case Bold:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("**" + *(this->productions[0]->value) + "**"));
        break;
    
    case Sout:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("~~" + *(this->productions[0]->value) + "~~"));
        break;

    case Imath:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("$" + *(this->productions[0]->value) + "$"));
        break;

    case Dmath:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("$$" + *(this->productions[0]->value) + "$$"));
        break;

    case Italic:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("*" + *(this->productions[0]->value) + "*"));
        break;

    case Url:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Ostatement:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Operationlist:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;
    
    case Blocks:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Empty:
        break;

    case List:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Codecontent:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        break;
    
    case Code:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string("```" + *(this->productions[0]->value) + "```"));
        break;

    case Symbols:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break; 

    case Lsentences:
        if(static_cast<int>(this->productions.size()) == 2){
            this->productions[0]->convert2Markdown();
            this->productions[1]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }else{
            this->productions[0]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value)));
        }
        break;

    case Ospaces:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[1]->value) + *(this->productions[0]->value)));
        break;

    case Ospace:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Sentences:
        if(static_cast<int>(this->productions.size()) == 2){
            this->productions[0]->convert2Markdown();
            this->productions[1]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }else{
            this->productions[0]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value)));
        }
        break;

    case Sentence:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Gdata:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Gsentences:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[1]->value) + *(this->productions[0]->value)));
        break;    

    case Gsentence:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    case Operations:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;
    
    case Oitem:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        if(this->productions[0]->getType() == Lsentences){
            for(int i = 1 ; i < this->depth ; i++){
                this->setValue(new std::string(*(this->value) + "   "));
            }
            this->setValue(new std::string(*(this->value) + "1." + *(this->productions[0]->value) + *(this->productions[1]->value)));
        }else{
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }
        break;

    case Unoitem:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        if(this->productions[0]->getType() == Lsentences){
            for(int i = 1 ; i < this->depth ; i++){
                this->setValue(new std::string(*(this->value) + "   "));
            }
            this->setValue(new std::string(*(this->value) + "-" + *(this->productions[0]->value) + *(this->productions[1]->value)));
        }else{
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }
        break;

    case Tcontent:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
       
        if(this->productions[1]->getType() == Tlines){
            this->setValue(new std::string(*(this->productions[0]->value) + "| " +  *(this->productions[1]->value) + "|\n"));
            if(this->rownum == 1){
                std::string* temp = new std::string("");
                for(int i = this->tstruct.size()-1 ; i >= 0; i--){
                    if(this->tstruct[i] == "l"){
                        temp = new std::string(*temp + "| :--- ");
                    }else if(this->tstruct[i] == "r"){
                        temp = new std::string(*temp + "| ---: ");
                    }else{
                        temp = new std::string(*temp + "| :---: ");
                    }
                    
                }
                temp = new std::string(*temp + "|\n");
                this->setValue(new std::string(*(this->value) + *temp));
            }
        }else{
             this->setValue(new std::string(*(this->productions[0]->value) ));
        }
        break;

    case Tlines:
        if(static_cast<int>(this->productions.size()) == 2){
            this->productions[0]->convert2Markdown();
            this->productions[1]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
            
        }else{
            this->productions[0]->convert2Markdown();
            this->setValue(new std::string(*(this->productions[0]->value)));
        }
        break;

    case Tline:
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        if(this->productions[0]->getType() == Text){
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }else{
            this->setValue(new std::string(" | " + *(this->productions[1]->value)));
        }
        break;


    case Hline:
        this->setValue(new std::string(""));
        break;

    case Table:
        this->productions[0]->convert2Markdown();
        this->setValue(new std::string(*(this->productions[0]->value)));
        break;

    default:
        break;
    }
}


/**
     * @brief Prints the Abstract syntax tree depth wise.
     * 
     * @param node The node which type will be printed.
     * @param depth The depth at which the current node is present.
*/
void Node::printAST(Node* node, int depth, std::ofstream& astPointer){
    if(node->productions.size() == 2){
        for(int i = 0 ; i < depth; i++){
            astPointer << " ";
        }
        astPointer << getEnumValue(node->getType()) << "\n";
        printAST(node->productions[0], depth + 1, astPointer);
        printAST(node->productions[1], depth + 1,astPointer);
    }else if(node->productions.size() == 1){
        for(int i = 0 ; i < depth; i++){
            astPointer << " ";
        }
        astPointer << getEnumValue(node->getType()) << "\n";
        printAST(node->productions[0], depth + 1,astPointer);
    }   
}