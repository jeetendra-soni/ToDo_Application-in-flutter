import 'package:firebase_auth/firebase_auth.dart';

import 'firestore.dart';


abstract class AuthenticationDatasource{
  Future<void> register(String email, String password, String confirmPassword);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource{
  @override
  Future<void> login(String email, String password) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(String email, String password, String confirmPassword) async{
    if(confirmPassword  == password){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((value) {
        Firestore_Datasource().CreateUser(email);
      });
    }
  }
}