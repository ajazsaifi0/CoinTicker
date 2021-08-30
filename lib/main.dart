import 'dart:io';

import 'package:flutter/material.dart';
import 'package:currency_convertor/price_screen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
String Connection;
  Future<String> InternetConnectionCheck() async{


    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return 'connected';
      }
    } on SocketException catch (_) {
      return 'not connected';
    }
  }
  void NoInternetConnection()async {
    Connection = await InternetConnectionCheck();
  }
  Widget getAlert(){
    return Container(
    child:  AlertDialog(
    title: Text('No Internet Connection'),
    content: SingleChildScrollView(
    child: ListBody(
    children:<Widget>[
    Text('Please Check Your Internet Connection'),
    Text('Then Try Again'),
    ],
    ),
    ),
    actions:<Widget> [
    TextButton(onPressed: (){
    //exit(0);
    SystemNavigator.pop();
    },child: Text("OK"))
    ],


    )

    );
  }

  @override
  Widget build(BuildContext context) {
    NoInternetConnection();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(primaryColor:Colors.lightBlue,scaffoldBackgroundColor: Colors.white ),
      home: Connection=="not connected"?getAlert():PriceScreen(),
    );
  }

}



