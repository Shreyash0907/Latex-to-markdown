%debug
%{
    #include <stdio.h>
    #include <string.h>
    extern int yylineno;
%}

%union {
    char *str;
}

%type <str> operations
%type <str> unoitem
%type <str> oitem
%type <str> tcontent
%type <str> codecontent start
%token OTHER
%token LCURB RCURB APER TAB SPACE BSLASH PIPE NEWLINE LSQRB RSQRB
%token TEXT
%token ITALIC BOLD HREF GRAPHIC
%token HRULE SECTION PARAGRAPH ITEM SUBSECTION SUBSUBSECTION HLINE
%token BCBLOCK ECBLOCK
%token BOLIST EOLIST BUNOLIST EUNOLIST
%token BTABLE ETABLE
%token BDOC EDOC
%start start

%%
    start : startingtext start {$$ = ""};
            | BDOC program EDOC {$$ = $2;};
             ;
            
    program : 
            | operationList program  {$$ = $1 + $2;}
           | blocks program          {$$ = $1 + $2;}
            ;
    blocks : BUNOLIST unoitem EUNOLIST 
            | BOLIST oitem EOLIST 
            | BTABLE LCURB tstructure RCURB NEWLINE tcontent ETABLE 
            | BCBLOCK codecontent ECBLOCK 
            ;


    operationList: operations
            ;

    operations: sentences {printf("word");}
              | ITALIC ostatement {printf("italic");}
              | BOLD ostatement {printf("bold");}
              | SECTION ostatement {printf("section");}
              | SUBSECTION ostatement {printf("subsection");}
              | SUBSUBSECTION ostatement {printf("subsubsection");}
              | HREF LCURB sentences RCURB ostatement {printf("href");}
              | HRULE {printf("hrule");}
              | GRAPHIC gdata ostatement {printf("graphic");}
              | PARAGRAPH {printf("paragraph");}
              ;

    ostatement : LCURB operations RCURB {printf("ostatement");} 

    unoitem : ospaces ITEM sentences {printf("unoitem");};
            | ospaces ITEM sentences unoitem {printf("unoitem");};
            ;

    oitem :ospaces ITEM sentences     {printf("oitem");};
            | ospaces ITEM sentences oitem  {printf("oitem");};
            ;

    tstructure : 
               | PIPE tstructure
               | TEXT tstructure
                ;
               
    tcontent : {printf("tcontent");}
             | tlines BSLASH BSLASH ospaces tcontent    {printf("tcontent");}
             | HLINE ospaces tcontent {printf("hline");}
            ;

    tlines : tline
           | tline tlines
        ;

    tline : TEXT ospaces
          | APER ospaces
          ;

    gdata : 
            | LSQRB gsentences RSQRB 

    codecontent : sentences  {printf("codecontent");};
    startingtext : TEXT 

    sentences : sentence 
                | sentence sentences;

    ospace : SPACE                  {$$ = yyval.text}
            | NEWLINE
            ;

    ospaces : 
            | ospaces ospace
            ;

    gsentences: 
                | gsentences gsentence
                ;
    
    gsentence : BSLASH 
                | sentence

    sentence : TEXT | ospace;

%%

int main(){
    #ifdef YYDEBUG
  yydebug = 1;
#endif

    yyparse();
    return 0;
}

void token(const char* s){
    //printf("%s\n", s);
    return;
}

void yyerror(const char *s){
    extern char *yytext;  // Include the current token text
    fprintf(stderr, "Error: %s at line %d near token '%s'\n", s, yylineno, yytext);
}
