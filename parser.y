%{
    #include <string>
    extern int yylineno;
    std::string* outputStr;
%}

%code requires {
    #include <cstdio>
    #include <string>
    using namespace std;
    extern int yylex(void);
    static void yyerror(const char* s); 
    std::string* getOutput();
    int cnt();
}

%union {
     std::string* str;
}

%type <str> operations
%type <str> unoitem gsentence gsentences 
%type <str> oitem gdata sentence sentences ospace ospaces 
%type <str> tcontent tstructure tline tlines 
%type <str> codecontent start program blocks operationList ostatement
%token OTHER
%token LCURB RCURB APER TAB SPACE BSLASH PIPE NEWLINE LSQRB RSQRB
%token <str> TEXT
%token ITALIC BOLD HREF GRAPHIC
%token HRULE SECTION PARAGRAPH ITEM SUBSECTION SUBSUBSECTION HLINE
%token BCBLOCK ECBLOCK
%token BOLIST EOLIST BUNOLIST EUNOLIST
%token BTABLE ETABLE
%token BDOC EDOC


%start start

%%
    start : startingtext start {};
            | BDOC program EDOC {outputStr = $2;};
             ;
            
    program :                          {   } 
            | operationList program  {$$ = new std::string(*$1 + *$2); delete $1; delete $2;}
            | blocks program         {$$ = new std::string(*$1 + *$2); delete $1; delete $2;}
            ;
    blocks : BUNOLIST unoitem EUNOLIST                  {$$ = $2;}
            | BOLIST oitem EOLIST                       {$$ = $2;}
            | BTABLE LCURB tstructure RCURB NEWLINE tcontent ETABLE {$$ = $3;}
            | BCBLOCK codecontent ECBLOCK {$$ = $2;}
            ;


    operationList: operations {$$ = $1;}
            ;

    operations: sentences {$$ = $1;}
              | ITALIC ostatement {$$ = new std::string("*" + *$2 + "*");}
              | BOLD ostatement {$$ = new std::string("**" + *$2 + "**");}
              | SECTION ostatement {$$ = new std::string("# " + *$2+"\n");}
              | SUBSECTION ostatement {$$ = new std::string("## " + *$2);}
              | SUBSUBSECTION ostatement {$$ = new std::string("### " + *$2);}
              | HREF LCURB sentences RCURB ostatement {$$ = new std::string("[" + *$5 + "]" + "(" + *$3 + ")" );}
              | HRULE {$$ = new std::string("<br>---<br>");}
              | GRAPHIC gdata ostatement {$$ = new std::string("![" + *$3 + "]{"+ *$2 + "}" );}
              | PARAGRAPH {$$ = new std::string("<br>");}
              ;

    ostatement : LCURB operations RCURB {$$ = new std::string(*$2);} 

    unoitem : ospaces ITEM sentences {$$ = new std::string("- " + *$1 + *$3 + "<br>");};
            | ospaces ITEM sentences unoitem {$$ = new std::string("- " + *$1 + *$3 + "<br>" + *$4);};
            ;

    oitem :   ospaces ITEM sentences     {$$ = new std::string("1. " + *$1 + *$3 + "<br>");};
            | ospaces ITEM sentences oitem  {$$ = new std::string("1. " + *$1 + *$3 + "<br>" + *$4);};
            ;

    tstructure :        {}
               | PIPE tstructure {$$ = new std::string("|" + *$2);};
               | TEXT tstructure {$$ = new std::string(*$1 + *$2);};
                ;
               
    tcontent : {}
             | tlines BSLASH BSLASH ospaces tcontent    {{$$ = new std::string("|" + *$1);};}
             | HLINE ospaces tcontent {{$$ = new std::string("<br>" + *$2 + *$3);};}
            ;

    tlines : tline  {$$ = new std::string(*$1);};
           | tline tlines  {$$ = new std::string(*$1 + *$2);};
        ;

    tline : TEXT ospaces {$$ = new std::string(*$1 + *$2);};
          | APER ospaces {$$ = new std::string("|" + *$2);};
          ;

    gdata :  {}
            | LSQRB gsentences RSQRB {$$ = new std::string( *$2 );};

    codecontent : sentences  {$$ = new std::string(*$1);};
    startingtext : TEXT {}

    sentences : sentence {$$ = new std::string(*$1);};
                | sentence sentences {$$ = new std::string(*$1 + *$2);};
                ; 

    ospace : SPACE   {$$ = new std::string(" ");};
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

%%

std::string* getOutput(){
        return outputStr; 
}

int cnt(){
        return 10;
}

void yyerror(const char *s){
    extern char *yytext;
    fprintf(stderr, "Error: %s at line near token '%s'\n", s, yytext);
}
