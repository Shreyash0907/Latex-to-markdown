%{
    #include <string>
    extern int yylineno;
    std::string* outputStr;

    int cnt = 1;
    int tcol = 0;
    int trow = 0;
%}

%code requires {
    #include <cstdio>
    #include <string>
    using namespace std;
    extern int yylex(void);
    static void yyerror(const char* s); 
    std::string* getOutput();
}

%union {
     std::string* str;
}

%type <str> operations
%type <str> unoitem gsentence gsentences 
%type <str> oitem gdata sentence sentences ospace ospaces 
%type <str> tcontent tstructure tline tlines lsentences symbols
%type <str> codecontent start program blocks operationList ostatement
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
            | BDOC NEWLINE program EDOC {outputStr = $3;};
             ;
            
    program :                          { $$ = new std::string("");  } 
            | operationList program  {$$ = new std::string(*$1 + *$2); delete $1; delete $2;}
            | blocks program         {$$ = new std::string(*$1 + *$2); delete $1; delete $2;}
            ;
    blocks : BUNOLIST unoitem EUNOLIST NEWLINE                {$$ = $2;}
            | BOLIST oitem EOLIST NEWLINE                     {$$ = $2;}
            | BTABLE LCURB tstructure RCURB NEWLINE tcontent ETABLE {$$ = new std::string( *$6);}
            | BCBLOCK codecontent ECBLOCK {$$ = new std::string("```" + *$2 + "```");}
            ;


    operationList: operations {$$ = $1;}
            ;

    operations: sentences {$$ = $1;}
              | ITALIC ostatement {$$ = new std::string("*" + *$2 + "*");}
              | BOLD ostatement {$$ = new std::string("**" + *$2 + "**");}
              | SECTION ostatement {$$ = new std::string("# " + *$2);}
              | SUBSECTION ostatement {$$ = new std::string("## " + *$2);}
              | SUBSUBSECTION ostatement {$$ = new std::string("### " + *$2);}
              | HREF LCURB sentences RCURB ostatement {$$ = new std::string("[" + *$5 + "]" + "(" + *$3 + ")" );}
              | HRULE {$$ = new std::string("---");}
              | GRAPHIC gdata ostatement {$$ = new std::string("![Image]("+ *$3 + ")" );}
              | PARAGRAPH {$$ = new std::string("\n");}
              ;

    ostatement : LCURB operations RCURB {$$ = new std::string(*$2);} 

    unoitem : ospaces ITEM lsentences {$$ = new std::string("-" + *$3); delete $3;};
            | ospaces ITEM lsentences unoitem {$$ = new std::string("-" + *$3 + *$4); delete $3; delete $4;};
            ;

    oitem :     {$$ = new std::string("");};
            | oitem ospaces ITEM lsentences  {
                                                $$ = new std::string(*$1 + std::to_string(cnt++) + "." + *$4);
                                                delete $4; delete $1;;
                                            };
            ;

    tstructure :        {$$ = new std::string("");}
               | PIPE tstructure {$$ = new std::string("|" + *$2);};
               | TEXT tstructure {$$ = new std::string(*$1 + *$2); tcol++;};
                ;
               
    tcontent : {$$ = new std::string("");}
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
             | tcontent HLINE ospaces  {{$$ = new std::string(*$1);};}
            ;

    tlines : tline  {$$ = new std::string(*$1);};
           | tline tlines  {$$ = new std::string(*$1 + *$2);};
        ;

    tline : TEXT ospaces {$$ = new std::string(*$1 + *$2);};
          | APER ospaces {$$ = new std::string("|" + *$2);};
          ;

    gdata :  {}
            | LSQRB gsentences RSQRB {$$ = new std::string( *$2 );};

    codecontent :  { $$ = new std::string("");}
                | sentences codecontent  {$$ = new std::string(*$1 + *$2); delete $2; delete $1;};
                | symbols codecontent    {$$ = new std::string( *$1 + *$2) ; delete $2; delete $1;}

    symbols : LCURB {$$ = new std::string("{");}
            | RCURB {$$ = new std::string("}");}
            | LSQRB {$$ = new std::string("[");}
            | RSQRB {$$ = new std::string("]");}
            | APER  {$$ = new std::string("&");}
            | PIPE  {$$ = new std::string("|");}
            | BSLASH {$$ = new std::string("\\");}
    startingtext : TEXT {}

    sentences : sentence {$$ = new std::string(*$1);};
                | sentence sentences {$$ = new std::string(*$1 + *$2);};
                ; 

    ospace : SPACE   {$$ = $1;};
            | NEWLINE  {$$ = new std::string("\n");};
            ;

    ospaces :   {$$ = new std::string("");};
            | ospaces ospace {$$ = new std::string(*$2 + *$1);};
            ;

    gsentences:         {$$ = new std::string("");};
                | gsentences gsentence {$$ = new std::string(*$2 + *$1);};
                ;
    
    gsentence : BSLASH {}
                | sentence {$$ = $1;}

    sentence : TEXT {$$ = $1;}
             | ospace  {$$ = $1;}
             ;

    lsentences : NEWLINE {$$ = new std::string("\n");}
                | SPACE lsentences {$$ = new std::string(*$1 + *$2);}
                | TEXT lsentences { $$ = new std::string(*$1 + *$2);}

%%

std::string* getOutput(){
        return outputStr; 
}


void yyerror(const char *s){
    extern char *yytext;
    fprintf(stderr, "Error: %s at line near token '%s'\n", s, yytext);
}
