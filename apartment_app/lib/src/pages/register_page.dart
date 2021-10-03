import 'package:apartment_app/src/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  late FirebaseAuth _firebaseAuth;

  void onSignUp() {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: "lehoangphuc272@gmail.com",
        password: "1234556789"
    );
  }

  @override
  Widget build(BuildContext context) {
    final userRepo = UserRepo();
    userRepo.createUserWithEmailAndPassword("lehoangphuc272@gmail.com", "123456789");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 400,),
            SizedBox(
              width: 100,
              height: 60,

              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                onPressed: onSignUp,
                child: Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

