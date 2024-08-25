/**
 * @file lexer.l
 * @brief Flex file for generation of tokens.
 * 
 * This file contains the lexer rules and actions for tokenizing the latex code.
 */
%{

    #include <stdio.h>
    #include "Node.hpp"
    #include "parser.tab.hpp"

%}


/*!*
 * @brief Token for alphabet.
 */
ALPHABET            [a-zA-Z]

/*!*
 * @brief  Token for numbers.
 */                         
NUMERIC             [0-9]

/*!*
 * @brief  Token for back slash.
 */                             
BSLASH              \\

/*!*
 * @brief  Token for space.
 */
SPACE               " "

/**
 * @brief  Token for special character.
 */
SCHAR               [\|\-]

/**
 * @brief Token for punctuation.
 */
PUNCTUATION         [!\""#\%\''()*+,\-./:;<=>?@^_`~]

/**
 * @brief Token for word.
 */
WORD                (({ALPHABET}|{NUMERIC})+({ALPHABET}|{NUMERIC})*)

/**
 * @brief Token for text.
 */
TEXT                (({WORD}|{PUNCTUATION})+)

/**
 * @brief Token for left curly bracket.
 */
LCURB               \{

/**
 * @brief Token for right curly bracket.
 */
RCURB               \}

/**
 * @brief Token for Amparsand.
 */
APER                \&

/**
 * @brief Token for left square bracket.
 */
LSQRB               \[

/**
 * @brief Token for right square bracket.
 */
RSQRB               \]

/**
 * @brief Token for pipe.
 */
PIPE                "|"

/**
 * @brief Token for dollar.
 */
DOLLAR              "$"

/**
 * @brief Token for newlline.
 */
NEWLINE             "\n"

/**
 * @brief Token for tab.
 */
TAB                 "\t"

/**
 * @brief Token for italic.
 */
ITALIC              "textit"

/**
 * @brief Token for bold.
 */
BOLD                "textbf"

/**
 * @brief Token for paragraph.
 */
PARAGRAPH           "par"

/**
 * @brief Token for section.
 */
SECTION             "section"

/**
 * @brief Token for subsection.
 */
SUBSECTION          "subsection"

/**
 * @brief Token for subsubsection.
 */
SUBSUBSECTION       "subsubsection"

/**
 * @brief Token for href.
 */
HREF                "href"

/**
 * @brief Token for hrule.
 */
HRULE               "hrule"

/**
 * @brief Token for hline.
 */
HLINE               "hline"

/**
 * @brief Token for graphic.
 */
GRAPHIC             "includegraphics"

/**
 * @brief Token for operations.
 */
OPERATION           ({BOLD}|{ITALIC}|{SECTION}|{PARAGRAPH}|{HREF}|{HRULE}|{GRAPHIC})

/**
 * @brief Token for begin.
 */
BEGIN               "begin"

/**
 * @brief Token for end.
 */
END                 "end"

/**
 * @brief Token for document.
 */
DOCUMENT            "document"

/**
 * @brief Token for tabular.
 */
TABLE               "tabular"

/**
 * @brief Token for itemize.
 */
UNOLIST             "itemize"

/**
 * @brief Token for enumerate.
 */
OLIST               "enumerate"

/**
 * @brief Token for code block.
 */
CBLOCK              "verbatim"

/**
 * @brief Token for item.
 */
ITEM                "item"

/**
 * @brief Token for strike through.
 */
SOUT                "sout"

/**
 * @brief Token for block type.
 */
BTYPE               ({DOCUMENT}|{TABLE}|{UNOLIST}|{OLIST}|{CBLOCK})
OSPACE              ({NEWLINE}|{SPACE})

%%

{BSLASH}{ITALIC}                                {return ITALIC;  };
{BSLASH}{BOLD}                                  {return BOLD; };
{BSLASH}{PARAGRAPH}                             {return PARAGRAPH;};
{BSLASH}{HRULE}                                 {return HRULE; };
{BSLASH}{SUBSUBSECTION}                         {return SUBSUBSECTION; };
{BSLASH}{SUBSECTION}                           {return SUBSECTION; };
{BSLASH}{SECTION}                               {return SECTION; };
{BSLASH}{ITEM}                                  {return ITEM; };
{BSLASH}{GRAPHIC}                               {return GRAPHIC; };
{BSLASH}{HLINE}                                 {return HLINE; };
{BSLASH}{HREF}                                  {return HREF; };
{BSLASH}{SOUT}                                  {return SOUT; };

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
{BSLASH}{LSQRB}                                 {return DMOPEN; };
{BSLASH}{RSQRB}                                 {return DMEND; };

{DOLLAR}                                        {return IMATH; };
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
                                                }
.                                               {printf("hrere");return yytext[0]; };


%%

int yywrap(){
    return 1;
}
