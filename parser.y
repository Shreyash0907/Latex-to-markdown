%debug
%{
    #include <string>
    #include<vector>
    #include "/mnt/d/Mtech/COP701/Latex-to-markdown/Node.hpp"
    extern int yylineno;
    std::string* outputStr;
    Node* root;


    int cnt = 0;
    int tcol = 0;
    int trow = 0;
%}

%code requires {
    #include <cstdio>
    #include <string>
    #include <vector>
    #include "/mnt/d/Mtech/COP701/Latex-to-markdown/Node.hpp"
    using namespace std;
    extern int yylex(void);
    static void yyerror(const char* s); 
    std::string* getOutput();
}

%union {
     std::string* str;
}

%type <Node> operations
%type <Node> unoitem gsentence gsentences 
%type <Node> oitem gdata sentence sentences ospace ospaces 
%type <Node> tcontent tstructure tline tlines lsentences symbols list
%type <Node> codecontent start program blocks operationList ostatement table thead url
%token OTHER
%token LCURB RCURB APER TAB BSLASH PIPE NEWLINE LSQRB RSQRB
%token <str> TEXT SPACE
%token ITALIC BOLD HREF GRAPHIC
%token HRULE SECTION PARAGRAPH ITEM SUBSECTION SUBSUBSECTION HLINE
%token BCBLOCK ECBLOCK
%token BOLIST EOLIST BUNOLIST EUNOLIST
%token BTABLE ETABLE
%token BDOC EDOC


%start start

%%
    start : startingtext start {};
            | BDOC NEWLINE program EDOC                 {
                                                            root = new Node(start);
                                                            root->value = "";
                                                            root->productions.push_back($1);
                                                            root->productions.push_back($2);
                                                            root->productions.push_back($3);
                                                            root->productions.push_back($4);
                                                            

                                                        };
             ;
            
    program :                                           {
                                                            $$ = new Node(program);
                                                            $$->value = "";
                                                            
                                                        } 
            | operationList program                     {
                                                            $$ = new Node(program);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1; delete $2;
                                                        }
            | blocks program                            {
                                                            $$ = new Node(program);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1; delete $2;
                                                        }
            ;


    blocks : list                                       {
                                                            $$ = new Node(blocks);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);

                                                            delete $1;
                                                        }
            | BTABLE table ETABLE                       {
                                                            $$ = new Node(blocks);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($3);
                                                            
                                                            delete $1; delete $2; delete $3;
                                                        }
            | BCBLOCK codecontent ECBLOCK               {
                                                            $$ = new Node(blocks);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($3);
                                                            
                                                            delete $1; delete $2; delete $3;
                                                        }
            ;

    table : thead NEWLINE tcontent                      {
                                                            $$ = new Node(table);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($3);
                                                            
                                                            delete $1; delete $2; delete $3;
                                                        }

    thead: LCURB tstructure RCURB                       {
                                                            $$ = new Node(thead);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($3);
                                                            
                                                            delete $1; delete $2; delete $3;
                                                        }

    list :  BUNOLIST unoitem EUNOLIST NEWLINE           {
                                                            $$ = new Node(list);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($3);
                                                            $$->productions.push_back($3);
                                                            
                                                            delete $1; delete $2; delete $3; delete $4;
                                                        }
           | BOLIST oitem EOLIST NEWLINE                {
                                                            $$ = new Node(list);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($3);
                                                            $$->productions.push_back($3);
                                                            
                                                            delete $1; delete $2; delete $3; delete $4;
                                                        }

    operationList: operations                           {
                                                            $$ = new Node(list);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            
                                                            delete $1;
                                                        }
            ;

    operations: sentences                               {
                                                            $$ = new Node(list);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);

                                                            delete $1;
                                                        }
              | ITALIC ostatement                       {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(italic);
                                                            temp->value = "";
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            delete $2;
                                                            delete temp;
                                                        }
              | BOLD ostatement                         {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(bold);
                                                            temp->value = "";
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            delete $2;
                                                            delete temp;
                                                        }
              | SECTION ostatement                      {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(section);
                                                            temp->value = "";
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            delete $2;
                                                            delete temp;
                                                        }
              | SUBSECTION ostatement                   {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(subsection);
                                                            temp->value = "";
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            delete $2;
                                                            delete temp;
                                                        }
              | SUBSUBSECTION ostatement                {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(subsubsection);
                                                            temp->value = "";
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            delete $2;
                                                            delete temp;
                                                        }
              | HREF url ostatement                     {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(href);
                                                            temp->value = "";
                                                            temp->productions.push_back($2);
                                                            temp->productions.push_back($3);

                                                            $$->productions.push_back(temp);

                                                            delete $2;
                                                            delete $3;
                                                            delete temp;
                                                        }
              | HRULE                                   {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(hrule);
                                                            temp->value = "";

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
              | GRAPHIC gdata ostatement                {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(graphic);
                                                            temp->value = "";
                                                            temp->productions.push_back($3);

                                                            $$->productions.push_back(temp);

                                                            delete $3;
                                                            delete temp;
                                                        }
              | PARAGRAPH                               {
                                                            $$ = new Node(operations);
                                                            $$->value = "";

                                                            Node* temp = new Node(paragraph);
                                                            temp->value = "";

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
              ;

    url : LCURB sentences RCURB                         {
                                                            $$ = new Node(url);
                                                            $$->value = "";

                                                            $$->productions.push_back($2);

                                                            delete $2;
                                                        }

    ostatement : LCURB operations RCURB                 {
                                                            $$ = new Node(ostatement);
                                                            $$->value = "";

                                                            $$->productions.push_back($2);

                                                            delete $2;
                                                        } 

    unoitem :                                           {
                                                            $$ = new Node(unoitem);
                                                            $$->value = "";
                                                        };
            | ospaces ITEM lsentences unoitem           {
                                                            $$ = new Node(unoitem);
                                                            $$->value = "";
                                                            $$->productions.push_back($3);
                                                            $$->productions.push_back($4);

                                                            delete $4;
                                                            delete $3;
                                                        };
            | list unoitem                              {
                                                            $$ = new Node(unoitem);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1;
                                                            delete $2;
                                                        }
            ;

    oitem :                                             {
                                                            $$ = new Node(oitem);
                                                            $$->value = "";
                                                        };
            | ospaces ITEM lsentences oitem             {
                                                            $$ = new Node(oitem);
                                                            $$->value = "";
                                                            $$->productions.push_back($3);
                                                            $$->productions.push_back($4);

                                                            delete $4;
                                                            delete $3;
                                                        };
            | list oitem                                {
                                                            $$ = new Node(oitem);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1;
                                                            delete $2;
                                                        }
            ;

    tstructure :                                        {
                                                            $$ = new Node(tstructure);
                                                            $$->value = "";
                                                        }
               | PIPE tstructure                        {
                                                            $$ = new Node(tstructure);
                                                            $$->value = "";
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1;
                                                            delete $2;
                                                        };
               | TEXT tstructure                        {
                                                            $$ = new Node(tstructure);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(text);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);  

                                                            delete $2; delete temp;
                                                        };
                ;
               
    tcontent :                                          {
                                                            $$ = new Node(tcontent);
                                                            $$->value = new std::string("");
                                                        }
             | tcontent tlines BSLASH BSLASH ospaces     {
                                                            trow++;
                                                            string* temp = new std::string( *$1 + "| " + *$2 + "|\n" );
                                                            if(trow == 1){
                                                                for(int i = 0 ; i < tcol; i++){
                                                                    temp = new std::string(*temp + "| ----- ");
                                                                }
                                                                temp = new std::string(*temp + "|\n");
                                                            }
                                                            $$ = temp;
                                                        }
             | tcontent HLINE ospaces                   {
                                                            $$ = new Node(tcontent);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);

                                                            delete $1;
                                                        }
            ;

    tlines : tline                                      {
                                                            $$ = new Node(tlines);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);

                                                            delete $1;
                                                        };
           | tline tlines                               {
                                                            $$ = new Node(tlines);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1;
                                                        };
        ;

    tline : TEXT ospaces                                {
                                                            $$ = new Node(tline);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(text);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp)
                                                            $$->productions.push_back($2);

                                                            delete temp; delete $2;    
                                                        };
          | APER ospaces                                {
                                                            $$ = new Node(tline);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(aper);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            delete temp; delete $2;  
                                                        };
          ;

    gdata :                                             {}
            | LSQRB gsentences RSQRB                    {
                                                            $$ = new Node(gdata);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($2);

                                                            delete temp; delete $2;      
                                                        };

    codecontent :                                       {}
                | sentences codecontent                 {
                                                            $$ = new Node(codecontent);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);    
                                                            $$->productions.push_back($2);

                                                            delete $1; delete $2;    
                                                        };
                | symbols codecontent                   {
                                                            $$ = new Node(codecontent);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);    
                                                            $$->productions.push_back($2);

                                                            delete $2; delete $1;
                                                        }

    symbols : LCURB                                     {
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(lcurb);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
            | RCURB                                     {
                                                            
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(rcurb);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
            | LSQRB                                     {
                
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(lsqrb);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
            | RSQRB                                     {
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(rsqrb);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
            | APER                                      {
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(aper);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
            | PIPE                                      {
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(pipe);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
            | BSLASH                                    {
                                                            $$ = new Node(symbols);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(bslash);
                                                            temp->value = new std::string("");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }
    startingtext : TEXT {}

    sentences : sentence                                {
                                                            $$ = new Node(sentences);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);

                                                            delete $1;
                                                        };
                | sentence sentences                    {
                                                            $$ = new Node(sentences);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            delete $1; delete $2;
                                                        };
                ;

    ospace : SPACE                                      {
                                                            $$ = new Node(ospace);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(space);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        };
            | NEWLINE                                   {
                                                            $$ = new Node(ospace);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(newline);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);
                                                            delete temp;
                                                        };
            ;

    ospaces :                                           {};
            | ospaces ospace                            {
                                                            $$ = new Node(ospaces);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($1);

                                                            delete $1; delete $2;
                                                        };
            ;

    gsentences:                                         {}
                | gsentences gsentence                  {
                                                            $$ = new Node(gsentences);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($1);

                                                            delete $1; delete $2;    
                                                        };
                ;
    
    gsentence : BSLASH                                  {}
                | sentence                              {
                                                            $$ = new Node(gsentence);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);

                                                            delete $1;
                                                        }

    sentence : TEXT                                     {
                                                            $$ = new Node(sentence);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(text);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);

                                                            delete temp;
    }
             | ospace                                   {
                                                            $$ = new Node(sentence);
                                                            $$->value = new std::string("");
                                                            $$->productions.push_back($1);

                                                            delete $1; 
                                                        }
             ;

    lsentences : NEWLINE optspace                       {
                                                            $$ = new Node(sentence);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(newline);
                                                            temp->value = new std::string("\n");

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            delete temp; delete $2;
                                                        }
                | SPACE lsentences                      {
                                                            $$ = new Node(sentence);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(space);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            delete temp; delete $2;
                                                        }
                | TEXT lsentences                       {
                                                            $$ = new Node(sentence);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(test);
                                                            temp->value = new std::string(*$1);

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            delete temp; delete $2;
                                                        }
                ;
    
    optspace :                                          {}
               | SPACE                                  {
                                                            $$ = new Node(sentence);
                                                            $$->value = new std::string("");

                                                            Node* temp = new Node(newline);
                                                            temp->value = new std::string("\n");

                                                            $$->productions.push_back(temp);

                                                            delete temp;
                                                        }

%%

std::string* getOutput(){
        return outputStr; 
}


void yyerror(const char *s){
    extern char *yytext;
    fprintf(stderr, "Error: %s at line near token '%s'\n", s, yytext);
}
