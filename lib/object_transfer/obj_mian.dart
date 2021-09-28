

void main(){

  // Cat cat1 = Cat(name: "小花", age: 5);
  // print(cat1.json);
  //
  // Cat cat2 = Cat.copy(cat: cat1);
  // print(cat2.json);
  // cat2.info.name = "小明";
  // print(cat2.json);
  // print(cat1.json);


  Cat cat1 = Cat(name: "小花", age: 5);
  Cat cat2 = Cat(name: "小明", age: 6);
  Cat cat3 = Cat(name: "小红", age: 7);
  List<Cat> list = [cat1, cat2, cat3];
  list.forEach((element) {
    print(element.json);
  });
  cat2.info.name = "修改";
  list.forEach((element) {
    print(element.json);
  });
  List<Cat> list2 = [];


  list.forEach((element) {
    list2.add(element);
    // print(element.json);
  });
  cat2.info.name = "修改2";
  list2.forEach((element) {
    // list2.add(element);
    print(element.json);
  });

}




class Cat {

  Info info;

  Cat({String name, int age}){
   this.info = Info(name: name, age: age);
  }

  Cat.copy({Cat cat}){
    this.info = Info(name: cat.info.name, age: cat.info.age);
  }

  Map get json{
    return {"name": info.name, "age": info.age};
  }

}

class Info {
  String name;
  int age;

  Info({this.name, this.age});
}