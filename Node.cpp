#include "Node.hpp"

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
        this->setValue(new std::string("----"));
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
        // printf("int oitem");
        this->productions[0]->convert2Markdown();
        this->productions[1]->convert2Markdown();
        if(this->productions[0]->getType() == Lsentences){
            for(int i = 1 ; i < this->depth ; i++){
                this->setValue(new std::string(*(this->value) + "   "));
            }
            this->setValue(new std::string(*(this->value) + "1. " + *(this->productions[0]->value) + *(this->productions[1]->value)));
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
            this->setValue(new std::string(*(this->value) + "- " + *(this->productions[0]->value) + *(this->productions[1]->value)));
        }else{
            this->setValue(new std::string(*(this->productions[0]->value) + *(this->productions[1]->value)));
        }
        break;

    default:
        break;
    }
}