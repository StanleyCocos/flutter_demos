

void main(){

  // Map<String, dynamic> dd = {"dd": "11"};
  // if(dd is Map<String,dynamic>){
  //   print("fadsfadsf");
  // }
  //
  // print(dd.runtimeType);

  List<String> list = [];


  print(list[0] ?? "1");
  print(list.item<String>(0)?.length);

}

extension ListOption on List {

  E item<E>(int index){
    if(this.length <= index) return null;
    return this[index];
  }

}