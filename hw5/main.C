#include <iostream>
#include <iomanip>
#include "parser.H"

using namespace std;
int main(int argc,char* argv[]) {
   const char* fn = 0;
   if (argc == 2)
      fn = argv[1];
   //cout << argc << ":input filename:" << fn << endl;
   Parser p;
   p.run(fn);
   AST::Node* root = p.getRoot();
   if (root) {
      root->print(std::cout);
   } else std::cout << "couldn't parse" << std::endl;
}
