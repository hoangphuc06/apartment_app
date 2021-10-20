
import 'package:firebase_auth/firebase_auth.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  Future<void> resetPassWord( String email)async {
    await  this._firebaseAuth.sendPasswordResetEmail(email: email);

  }
  void signIn(String email, String pass, Function onSuccess, Function(String) onSignInError) {

    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
          onSuccess();
      }).catchError((err) {
      print("err: " + err.toString());
      onSignInError("Email hoặc mật khẩu không chính xác, vui lòng thử lại sau.");
    });
  }


}