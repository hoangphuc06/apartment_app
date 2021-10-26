import 'package:apartment_app/src/pages/category_apartment/firebase/fb_category_apartment.dart';
import 'package:apartment_app/src/model/categoty_apartment.dart';
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

  CategoryApartmentFB categoryApartmentFB = new CategoryApartmentFB();

  void onSignUp() {
    _firebaseAuth.createUserWithEmailAndPassword(
        email: "lehoangphuc272@gmail.com",
        password: "1234556789"
    );
  }

  void hihi() {
    final ca1 =  CategoryApartment("1","loai 1");
    final ca2 =  CategoryApartment("2","loai 2");
    final ca3 =  CategoryApartment("3","loai 3");
    // categoryApartmentFB.addCategoryApartment(ca1);
    // categoryApartmentFB.addCategoryApartment(ca2);
    // categoryApartmentFB.addCategoryApartment(ca3);
    // setState(() {
    //
    // });
    // categoryApartmentFB.add("1","loai 11");
    // categoryApartmentFB.add("2","loai 2");
    // categoryApartmentFB.add("3","loai 3");
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
                onPressed: hihi,
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

