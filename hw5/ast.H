#ifndef __AST_H
#define __AST_H

#include <iostream>
#include <iomanip>
#include <string>
#include <list>

namespace AST {
   using namespace std;
   class Node {
   public:
      Node() {}
      virtual ~Node() {}
      virtual ostream& print(ostream& os) const = 0;
   };
   
   class Expr : public Node {
   public:
      Expr() : Node() {}
   };

   class Type :public Node {
   public:
      Type() {}
   };

   class Decl :public Node {
   public:
      Decl() {}
   };

   class Class :public Node {
   public:
      Class() {}
   };

   class Stmt :public Node {
   public:
      Stmt() {}
   };

   class TypeInt : public Type {
   public:
      TypeInt() {}
      ostream& print(ostream& os) const { return os << "int";}
   };

   class Program : public Decl {
      std::list<Class*> _classes;
   public:
     Program(std::list<Class*>* c);
     ostream& print(ostream& os) const;
   };
};

#endif
