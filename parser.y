%debug
%{
    #include <string>
    #include<vector>
    #include "Node.hpp"
    extern int yylineno;
    Node* root;

    int cnt = 0;
    int tcol = 0;
    int trow = 0;
%}

%code requires {
    #include <cstdio>
    #include <string>
    #include <vector>
    #include "Node.hpp"
    using namespace std;
    extern int yylex(void);
    static void yyerror(const char* s); 
    Node* getRoot();
}

%union {
     std::string* str;
     Node* node;
}

%type <node> operations
%type <node> unoitem gsentence gsentences optspace
%type <node> oitem gdata sentence sentences ospace ospaces 
%type <node> tcontent tstructure tline tlines lsentences symbols list
%type <node> codecontent start program blocks operationList ostatement table thead url

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
    start : startingtext start                          {};
            | BDOC NEWLINE program EDOC                 {
                                                            root = new Node(Start);
                                                            root->setValue(new std::string(""));
                                                            root->productions.push_back($3);
                                                            
                                                        };
             ;
            
    program :                                           {
                                                            $$ = new Node(Empty);
                                                            $$->setValue(new std::string(""));
                                                        } 
            | operationList program                     {
                                                            $$ = new Node(Program);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                        }
            | blocks program                            {
                                                            $$ = new Node(Program);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                        }
            ;


    blocks : list                                       {
                                                            $$ = new Node(Blocks);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                        }
            | BTABLE table ETABLE                       {
                                                            $$ = new Node(Blocks);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($2);
                                                            
                                                            
                                                        }
            | BCBLOCK codecontent ECBLOCK               {
                                                            $$ = new Node(Blocks);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Code);
                                                            temp->setValue(new std::string(""));

                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);
                                                        }
            ;

    table : thead NEWLINE tcontent                      {
                                                            $$ = new Node(Table);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($3);
                                                            
                                                           
                                                        }

    thead: LCURB tstructure RCURB                       {
                                                            $$ = new Node(Thead);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($2);
                                                            
                                                           
                                                        }

    list :  BUNOLIST unoitem EUNOLIST NEWLINE           {
                                                            $$ = new Node(List);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($2);

                                                            
                                                        }
           | BOLIST oitem EOLIST NEWLINE                {
                                                            $$ = new Node(List);
                                                            $$->setValue(new std::string(""));                                              
                                                            $$->productions.push_back($2);
                                                            
                                                        }

    operationList: operations                           {
                                                            $$ = new Node(Operationlist);
                                                            $$->setValue(new std::string("operations"));
                                                            $$->productions.push_back($1);
                                                            
                                                            
                                                        }
            ;

    operations: sentences                               {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                            
                                                        }
              | ITALIC ostatement                       {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Italic);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
              | BOLD ostatement                         {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Bold);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
              | SECTION ostatement                      {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Section);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                           
                                                        }
              | SUBSECTION ostatement                   {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Subsection);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
              | SUBSUBSECTION ostatement                {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Subsubsection);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($2);

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
              | HREF url ostatement                     {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Href);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($2);
                                                            temp->productions.push_back($3);

                                                            $$->productions.push_back(temp);

                                                        }
              | HRULE                                   {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Hrule);
                                                           temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                        }
              | GRAPHIC gdata ostatement                {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Graphic);
                                                           temp->setValue(new std::string(""));
                                                            temp->productions.push_back($3);

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
              | PARAGRAPH                               {
                                                            $$ = new Node(Operations);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Paragraph);
                                                           temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                           
                                                        }
              ;

    url : LCURB sentences RCURB                         {
                                                            $$ = new Node(Url);
                                                            $$->setValue(new std::string(""));

                                                            $$->productions.push_back($2);

                                                            
                                                        }

    ostatement : LCURB operations RCURB                 {
                                                            $$ = new Node(Ostatement);
                                                            $$->setValue(new std::string(""));

                                                            $$->productions.push_back($2);

                                                        } 

    unoitem :                                           {
                                                            $$ = new Node(Empty);
                                                            $$->setValue(new std::string(""));
                                                        };
            | ospaces ITEM lsentences unoitem           {
                                                            $$ = new Node(Unoitem);
                                                            $$->depth = cnt;
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($3);
                                                            $$->productions.push_back($4);

                                                            
                                                        };
            | list unoitem                              {   printf("last --------");
                                                            $$ = new Node(Unoitem);
                                                            $$->setValue(new std::string(""));
                                                            
                                                        
                                                        }
            ;

    oitem :                                             {
                                                            $$ = new Node(Empty);
                                                            $$->setValue(new std::string(""));
                                                        };
            | ospaces ITEM lsentences oitem             {
                                                            $$ = new Node(Oitem);
                                                            $$->depth = cnt;
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($3);
                                                            $$->productions.push_back($4);

                                                          
                                                        };
            | list oitem                                {
                                                            $$ = new Node(Oitem);
                                                            $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);
                                                    
                                                        }
            ;

    tstructure :                                        {
                                                            $$ = new Node(Tstructure);
                                                            $$->setValue(new std::string(""));
                                                        }
                | PIPE tstructure                        {
                                                            $$ = new Node(Tstructure);
                                                            $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Pipe);
                                                            temp->setValue( new std::string("|"));

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            
                                                        };
               | TEXT tstructure                        {
                                                            $$ = new Node(Tstructure);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Text);
                                                            temp->setValue( new std::string(*$1));

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);  

                                                            
                                                        };
                ;
               
    tcontent :                                          {
                                                            $$ = new Node(Tcontent);
                                                           $$->setValue(new std::string(""));
                                                        }
             | tcontent tlines BSLASH BSLASH ospaces     {
                                                           /* trow++;
                                                            string* temp = new std::string( *$1 + "| " + *$2 + "|\n" );
                                                            if(trow == 1){
                                                                for(int i = 0 ; i < tcol; i++){
                                                                    temp = new std::string(*temp + "| ----- ");
                                                                }
                                                                temp = new std::string(*temp + "|\n");
                                                            }
                                                            $$ = temp;*/
                                                        }
             | tcontent HLINE ospaces                   {
                                                            $$ = new Node(Tcontent);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                            
                                                        }
            ;

    tlines : tline                                      {
                                                            $$ = new Node(Tlines);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                            
                                                        };
           | tline tlines                               {
                                                            $$ = new Node(Tlines);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            
                                                        };
        ;

    tline : TEXT ospaces                                {
                                                            $$ = new Node(Tline);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Text);
                                                            temp->setValue( new std::string(*$1));

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                             
                                                        };
          | APER ospaces                                {
                                                            $$ = new Node(Tline);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Aper);
                                                            temp->setValue(new std::string("&"));

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                              
                                                        };
          ;

    gdata :                                             {}
            | LSQRB gsentences RSQRB                    {
                                                            $$ = new Node(Gdata);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($2);

                                                                
                                                        };

    codecontent :                                       {
                                                            $$ = new Node(Empty);
                                                            $$->setValue(new std::string(""));
                                                        }
                | sentences codecontent                 {
                                                            $$ = new Node(Codecontent);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);    
                                                            $$->productions.push_back($2);

                                                            
                                                              
                                                        };
                | symbols codecontent                   {
                                                            $$ = new Node(Codecontent);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);    
                                                            $$->productions.push_back($2);

                                                            
                                                            
                                                        }

    symbols : LCURB                                     {
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Lcurb);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
            | RCURB                                     {
                                                            
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Rcurb);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
            | LSQRB                                     {
                
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Lsqrb);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
            | RSQRB                                     {
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Rsqrb);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
            | APER                                      {
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Aper);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
            | PIPE                                      {
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Pipe);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
            | BSLASH                                    {
                                                            $$ = new Node(Symbols);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Bslash);
                                                            temp->setValue(new std::string(""));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
    startingtext : TEXT                                 {}
                    | symbols                           {}
                    | NEWLINE                           {}

    sentences : sentence                                {
                                                            $$ = new Node(Sentences);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                            
                                                        };
                | sentence sentences                    {
                                                            $$ = new Node(Sentences);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);
                                                            $$->productions.push_back($2);

                                                            
                                                        };
                ;

    ospace : SPACE                                      {
                                                            $$ = new Node(Ospace);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Space);
                                                           temp->setValue(new std::string(*$1));

                                                            $$->productions.push_back(temp);

                                                            
                                                        };
            | NEWLINE                                   {
                                                            $$ = new Node(Ospace);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Newline);
                                                            temp->setValue(new std::string("\n"));

                                                            $$->productions.push_back(temp);
                                                            
                                                        };
            ;

    ospaces :                                           {};
            | ospaces ospace                            {
                                                            $$ = new Node(Ospaces);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($1);

                                                            
                                                        };
            ;

    gsentences:                                         {}
                | gsentences gsentence                  {
                                                            $$ = new Node(Gsentences);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($2);
                                                            $$->productions.push_back($1);

                                                                
                                                        };
                ;
    
    gsentence : BSLASH                                  {}
                | sentence                              {
                                                            $$ = new Node(Gsentence);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                            
                                                        }

    sentence : TEXT                                     {
                                                            $$ = new Node(Sentence);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Text);
                                                            temp->setValue(new std::string(*$1));

                                                            $$->productions.push_back(temp);

                                                            
                                                        }
             | ospace                                   {
                                                            $$ = new Node(Sentence);
                                                           $$->setValue(new std::string(""));
                                                            $$->productions.push_back($1);

                                                            
                                                        }
             ;

    lsentences : NEWLINE optspace                       {
                                                            $$ = new Node(Lsentences);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Newline);
                                                            temp->setValue(new std::string("\n"));

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            
                                                        }
                | SPACE lsentences                      {
                                                            $$ = new Node(Lsentences);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Space);
                                                            temp->setValue(new std::string(*$1));
                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                            
                                                        }
                | TEXT lsentences                       {
                                                            $$ = new Node(Lsentences);
                                                           $$->setValue(new std::string(""));

                                                            Node* temp = new Node(Text);
                                                            temp->setValue(new std::string(*$1));

                                                            $$->productions.push_back(temp);
                                                            $$->productions.push_back($2);

                                                        }
                ;
    
    optspace :                                          {
                                                            $$ = new Node(Empty);
                                                            $$->setValue(new std::string(""));
                                                        }              
               | SPACE                                  {
                                                            $$ = new Node(Empty);
                                                            $$->setValue(new std::string(""));
                                                        }

%%

Node* getRoot(){
        return root; 
}


void yyerror(const char *s){
    extern char *yytext;
    fprintf(stderr, "Error: %s at line near token '%s'\n", s, yytext);
}
