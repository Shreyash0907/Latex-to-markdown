\mainpage
# LaTeX-to-Markdown Converter

## Overview

**LaTeX-to-Markdown** is a converter that converts LaTeX code into Markdown code. This project uses Flex and Bison to tokenize and parse LaTeX code, generating an abstract syntax tree (AST) that is parsed to get the required Markdown code.

## Features Implemented

- Sections subsections and subsubsection
- Italics and bold (Nested bold and Italic)
- Horizontal line 
- Paragraph 
- Code blocks
- Hyperlink
- Images
- Ordered List
- Unordered List
- Tables
- Strike through
- Inline Math
- Display Math

## Workflow

1. **Tokenization**: The LaTeX code is first tokenized using Flex. Different tokens are generated based on the input Latex code. These tokens are passed to the parser for further processing.

2. **Parsing**: The tokens which are passed by lexer are parsed using Bison. While parsing the tokens the AST is created subsequently. This AST contains all the neccessary information about the type of command and its value.

3. **Markdown Conversion**: The AST which is generated during the parsing of the tokens is parsed from top to bottom to generate the equivalent markdown code. The AST is printed in the seperate file.

## Dependencies
- C++ (version GCC-6.3.0-1 or greater)
- Flex (flex 2.6.4 or greater)
- Bison (bison (GNU Bison) 3.8.2 or greater)
- Gtest
- Cmake


### Build Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Shreyash0907/Latex-to-markdown.git
   cd latex-to-markdown
   ```

2. **Build the project:**  
```bash
    mkdir build  
    cd build  
    cmake ..  
    cd ../  
    ```

3. **Execute run.sh:**
```bash  
    ./run.sh <input_file.tex> <output_file.md>
    ```

### Gtest Instruction

1. **Open Directory:**
```bash
    cd sampleTests
    mkdir build
    cd build
    cmake ..
    make 
    ```

2. **Execute Gtest:**
```bash
    ./unitTests
    ```
