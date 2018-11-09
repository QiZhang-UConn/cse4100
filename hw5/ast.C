#include "ast.H"

using namespace std;
namespace AST {
  Program::Program(std::list<Class*>* c) : _classes(*c) 
  { 
    delete c;
  }

  ostream& Program::print(ostream& os) const {
    for(std::list<Class*>::const_iterator it = _classes.begin();
	it != _classes.end();++it) {
      (*it)->print(os);
    }
    return os;
  }

}
