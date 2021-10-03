
import 'dart:async';

import 'package:apartment_app/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();

  Stream? get emailStream => _emailController.stream;
  Stream? get passStream => _passController.stream;

  void signIn(String email, String pass, Function onSuccess, Function(String) onError) {
    _firAuth.signIn(email, pass, onSuccess, onError);
  }

  bool checkSignIn(String email, String pass) {
    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void dispose() {
    _emailController.close();
    _passController.close();
  }
}