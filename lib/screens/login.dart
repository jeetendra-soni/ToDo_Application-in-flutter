import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/const/color.dart';
import 'package:todo_app/data/auth_data.dart';


class Login_Screen extends StatefulWidget {
  final VoidCallback show;
  Login_Screen( {Key? key, required this.show}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final c_passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusNode1.addListener(() {
      setState(() {});
    });

    _focusNode2.addListener(() {
      setState(() {});
    });

    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgrounColors,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Image(),

              //Email
              SizedBox(height: 50,),
              TextField(
                controller: emailController,
                focusNode: _focusNode1,
                typeName: "Email",
                icon: Icons.email,
                obscureText: false,
              ),

              //password
              SizedBox(height: 20,),
              TextField(
                controller: passwordController,
                focusNode: _focusNode2,
                typeName: "Password",
                icon: Icons.lock_person,
                obscureText: true
              ),


              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Don't have an account? ", style: TextStyle(color: Colors.grey.shade700, fontSize: 14),),
                    TextButton(
                      onPressed: widget.show ,
                      child: Text("Sign Up", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 14))),
                  ],
                ),
              ),

              //Login button
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  AuthenticationRemote().login(emailController.text, passwordController.text);
                },
                child: button(name: "Login"),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget Image(){
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_logo.jpg"),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
  
  Widget button({required String name}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: Text(name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CupertinoColors.white), textAlign: TextAlign.center,)),
      ),
    );
  }

  Widget TextField({required controller, required FocusNode focusNode, required String typeName, required IconData icon, required bool obscureText}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: focusNode.hasFocus? Colors.deepOrangeAccent:Colors.grey.shade400,),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: typeName,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.deepOrangeAccent, width: 2.0)
            ),
          ),
        ),
      ),
    );
  }
}

