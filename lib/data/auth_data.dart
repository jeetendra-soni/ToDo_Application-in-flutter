import 'package:firebase_auth/firebase_auth.dart';
abstract class AurthenticationDatasouece{
  Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AurthenticationDatasouece{
  @override
  Future<void> login(String email, String password) async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  @override
  Future<void> register(String email, String password, String PasswordConfirm) async{
    if(PasswordConfirm == password){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    }

  }
}