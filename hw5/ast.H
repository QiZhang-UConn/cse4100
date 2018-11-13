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

  class Binary: public Expr{
  protected:
    Expr* _left;
    Expr* _right;
    virtual const char* opName() const=0;
  public:
    Binary(Expr* l,Expr* r): _left(l), _right(r){}
    ostream& print(ostream& os)const;
  };

  class Add: public Binary{
    const char* opName() const{return "+";}
  public:
    Add(Expr* l, Expr* r):Binary(l,r){}
  };

  class Sub: public Binary{
    const char* opName() const{return "-";}
  public:
    Sub(Expr* l, Expr* r):Binary(l,r){}
  };

  class Mul: public Binary{
    const char* opName() const{return "*";}
  public:
    Sub(Expr* l, Expr* r):Binary(l,r){}
  };

  class Div: public Binary{
    const char* opName() const{return "/";}
  public:
    Div(Expr* l, Expr* r): Binary(l,r){}
  };

  class Number: public TypeInt{
    Number(TypeInt* n): {return n;}
			};
};

#endif
