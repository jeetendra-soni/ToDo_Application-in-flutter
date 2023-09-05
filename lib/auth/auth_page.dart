import 'package:flutter/material.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/screens/signup.dart';

class Auth_Page extends StatefulWidget {
  const Auth_Page({Key? key}) : super(key: key);

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {
  bool a = true;

  void show(){
    setState(() {
      a=!a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(a){
      return Login_Screen(show: () {  },);
    }else{
      return SignUp_Screen(show: () {  },);
    }
  }
}
