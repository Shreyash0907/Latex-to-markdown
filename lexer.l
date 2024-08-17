%{
    #include <stdio.h>
    #include "parser.tab.hpp"

%}

ALPHABET            [a-zA-Z]
NUMERIC             [0-9]
BSLASH              \\
SPACE               " "
SCHAR               [\|\-]
PUNCTUATION         [!\"#\$%\'()*+,\-./:;<=>?@^_`~]
WORD                (({ALPHABET}|{NUMERIC})+({ALPHABET}|{NUMERIC})*)
TEXT                (({WORD}|{PUNCTUATION})+)
LCURB               \{
RCURB               \}
APER                \&
LSQRB               \[
RSQRB               \]
PIPE                "|"
NEWLINE             "\n"
TAB                 "\t"
ITALIC              "textit"
BOLD                "textbf"
PARAGRAPH           "par"
SECTION             "section"
SUBSECTION          "subsection"
SUBSUBSECTION       "subsubsection"
HREF                "href"
HRULE               "hrule"
HLINE               "hline"
GRAPHIC             "includegraphics"
OPERATION           ({BOLD}|{ITALIC}|{SECTION}|{PARAGRAPH}|{HREF}|{HRULE}|{GRAPHIC})
BEGIN               "begin"
END                 "end"
BLOCK               ({BEGIN}|{END})
DOCUMENT            "document"
TABLE               "tabular"
UNOLIST             "itemize"
OLIST               "enumerate"
CBLOCK              "verbatim"
ITEM                "item"

BTYPE               ({DOCUMENT}|{TABLE}|{UNOLIST}|{OLIST}|{CBLOCK})

%%

{BSLASH}{ITALIC}                                {return ITALIC;  };
{BSLASH}{BOLD}                                  {return BOLD; };
{BSLASH}{PARAGRAPH}                             {return PARAGRAPH;};
{BSLASH}{HRULE}                                 {return HRULE; };
{BSLASH}{SUBSUBSECTION}                         {return SUBSUBSECTION; };
{BSLASH}{SUBSECTION}                            {return SUBSECTION; };
{BSLASH}{SECTION}                               {return SECTION; };
{BSLASH}{ITEM}                                  {return ITEM; };
{BSLASH}{GRAPHIC}                               {return GRAPHIC; };
{BSLASH}{HLINE}                                 {return HLINE; };
{BSLASH}{HREF}                                  {return HREF; };

{BSLASH}{BEGIN}{LCURB}{OLIST}{RCURB}            {return BOLIST; };
{BSLASH}{END}{LCURB}{OLIST}{RCURB}              {return EOLIST; };
{BSLASH}{BEGIN}{LCURB}{UNOLIST}{RCURB}          {return BUNOLIST; };
{BSLASH}{END}{LCURB}{UNOLIST}{RCURB}            {return EUNOLIST; };
{BSLASH}{BEGIN}{LCURB}{CBLOCK}{RCURB}           {return BCBLOCK ; };
{BSLASH}{END}{LCURB}{CBLOCK}{RCURB}             {return ECBLOCK ; };
{BSLASH}{BEGIN}{LCURB}{DOCUMENT}{RCURB}         {return BDOC; };
{BSLASH}{END}{LCURB}{DOCUMENT}{RCURB}           {return EDOC; };
{BSLASH}{BEGIN}{LCURB}{TABLE}{RCURB}            {return BTABLE; };
{BSLASH}{END}{LCURB}{TABLE}{RCURB}              {return ETABLE; };
{LCURB}                                         {return LCURB; };
{RCURB}                                         {return RCURB; };
{LSQRB}                                         {return LSQRB; };
{RSQRB}                                         {return RSQRB; };
{APER}                                          {return APER; };
{PIPE}                                          {return PIPE;};
{TAB}                                           {return TAB; };
{SPACE}{1,}                                     {
                                                    yylval.str = new std::string(yytext);
                                                    return SPACE;};
{NEWLINE}                                       {return NEWLINE;};
{BSLASH}                                        {return BSLASH; };
{TEXT}                                          {
                                                    yylval.str = new std::string(yytext);
                                                    return TEXT;
                                                };
.                                               {return yytext[0]; };

%%
int yywrap(){
    return 1;
}
