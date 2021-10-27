
import 'package:firebase_auth/firebase_auth.dart';

class FirAuth {
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;


  Future<void> resetPassWord( String email)async {
    await  this._firebaseAuth.sendPasswordResetEmail(email: email);

  }
  bool   updatePass(String pass){
    bool result=true;
    this._firebaseAuth.currentUser!.updatePassword(pass).then((_){
      print("Successfully changed password");
      result= true;
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      result= false;
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
    return result;
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