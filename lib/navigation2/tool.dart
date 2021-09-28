

import 'package:fluttertoast/fluttertoast.dart';

showToast(String msg, {String webPosition = "center"}){

  Fluttertoast.showToast(msg: msg, webPosition: webPosition, timeInSecForIosWeb: 5);

}