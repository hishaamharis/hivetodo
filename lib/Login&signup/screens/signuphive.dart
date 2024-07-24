import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../To_do/constants.dart';
import '../database/database.dart';
import '../model/usermodel.dart';
import 'loghive.dart';

main() {
  runApp(GetMaterialApp(debugShowCheckedModeBanner: false,
    home: Signuphive(),
  ));
}

class Signuphive extends StatelessWidget {

  var username = TextEditingController();

  var password = TextEditingController();

  var confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 160, left: 106, right: 106),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              child: TextField(
                controller: username,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "Username",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: TextField(
                controller: password,
                textInputAction: TextInputAction.next,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: TextField(
                controller: confirmpassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.visibility_off_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor),
                  onPressed: () async {
                    validatesignup();
                  },
                  child: Text(
                    "Sign UP",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 95, right: 95),
              child: Row(
                children: [
                  Text(
                    "Already a user",
                    style: TextStyle(fontSize: 17,color: primaryColor),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loghive(),
                            ));
                      },
                      child: Text(
                        "Login Here",
                        style: TextStyle(color: primaryColor, fontSize: 17),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void validatesignup () async{
    final email = username.text.trim();

    final pass = password.text.trim();

    final cpass = confirmpassword.text.trim();

    final emailValidationResult = EmailValidator.validate(email);

    if(email != "" && pass != "" && cpass != "" ){
      if (emailValidationResult == true){

        final passValidationResult = checkPassword(pass,cpass);
        if (passValidationResult == true){
          final user = User(email : email, password : pass);

          await DBFunction.instance.userSignUp(user);
          Get.back();
          Get.snackbar("Success", "Account created");
        }
      }
      else{
        Get.snackbar("Error", "Provide a valid email");
      }
    }
    else{
      Get.snackbar("Error", "Fields can not be empty");
    }
  }


  bool checkPassword(String pass, String cpass){
    if(pass == cpass){
      if(pass.length<6){
        Get.snackbar("Error", "Password length should be greater than 6");
        return false;
      } else {
        return true;
      }
    }
    else {
      Get.snackbar("Error", "Password mismatch");
      return false;
    }
  }
}
