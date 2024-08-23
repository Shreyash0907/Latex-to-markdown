#include <gtest/gtest.h>
#include "parser.tab.hpp"
#include "lex.yy.hpp"
#include "Node.hpp"
#include<string>

extern int yyparse(void);

std::string getMarkdown(string temp){

    extern FILE *yyin;
    yyin = fmemopen(const_cast<char*>(temp.c_str()),temp.length(),"r");
    yyparse();
    Node* root = getRoot();
    
    root->convert2Markdown();
    std::string answer = *(root->getValue());
    return answer;
}

TEST(Latex2Markdown, sectionCheck) {
    
    std::string temp = "\\begin{document}\n\\section{Introduction to IIT Delhi}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "# Introduction to IIT Delhi\n");
}


TEST(Latex2Markdown, italicCheck) {
    std::string temp = "\\begin{document}\n\\textit{Indian Institute of Technology Delhi (IIT Delhi)}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "*Indian Institute of Technology Delhi (IIT Delhi)*\n");
}



TEST(Latex2Markdown, subSectionCheck) {
    std::string temp = "\\begin{document}\n\\href{https://www.iitd.ac.in}{IIT Delhi Official Website}\n\\end{document}";
    
    EXPECT_STREQ(getMarkdown(temp).c_str(), "[IIT Delhi Official Website](https://www.iitd.ac.in)\n");
}

TEST(Latex2Markdown, boldCheck) {
    std::string temp = "\\begin{document}\n\\textbf{The IITD campus is very huge}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "**The IITD campus is very huge**\n");
}

TEST(Latex2Markdown, hrefCheck) {
    std::string temp = "\\begin{document}\n\\href{https://www.iitd.ac.in}{IIT Delhi Official Website}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "[IIT Delhi Official Website](https://www.iitd.ac.in)\n");
}

TEST(Latex2Markdown, unorderedListCheck) {
    std::string temp = "\\begin{document}\n\\begin{itemize}\n\\item this is first item\n\\item this is second item\n\\end{itemize}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "- this is first item\n- this is second item\n");
}

TEST(Latex2Markdown, orderedListCheck) {
    std::string temp = "\\begin{document}\n\\begin{enumerate}\n\\item this is first item\n\\item this is second item\n\\end{enumerate}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "1. this is first item\n1. this is second item\n");
}

TEST(Latex2Markdown, tableCheck) {
    std::string temp = "\\begin{document}\n\\begin{tabular}{|l|r|}\n\\hline\nDepartment & Programs \\\\\n\\hline\nComputer Science & B.Tech, M.Tech, Ph.D. \\\\\nElectrical Engineering & B.Tech, M.Tech, Ph.D. \\\\\n\\hline\n\\end{tabular}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "| Department  |  Programs |\n| :--- | ---: |\n| Computer Science  |  B.Tech, M.Tech, Ph.D. |\n| Electrical Engineering  |  B.Tech, M.Tech, Ph.D. |\n\n");
}

TEST(Latex2Markdown, graphicCheck) {
    std::string temp = "\\begin{document}\n\\includegraphics[width=0.5\\textwidth]{images/technology.jpg}\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "![Image](images/technology.jpg)\n");
}

TEST(Latex2Markdown, normalTextCheck) {
    std::string temp = "\\begin{document}\nThis is to check the normal text is working or not\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "This is to check the normal text is working or not\n");
}

TEST(Latex2Markdown, codeContentCheck) {
    std::string temp = "\\begin{document}\ndef iit_delhi_info():\n    print(\"Welcome to IIT Delhi!\")\n\\end{document}";

    EXPECT_STREQ(getMarkdown(temp).c_str(), "def iit_delhi_info():\n    print(\"Welcome to IIT Delhi!\")\n");
}


int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
