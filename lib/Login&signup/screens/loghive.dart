import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivetodo/Login&signup/screens/signuphive.dart';
import '../To_do/constants.dart';
import '../To_do/main.dart';
import '../database/database.dart';
import '../model/usermodel.dart';
import 'homehive.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Loghive(),
  ));
}

class Loghive extends StatelessWidget {
  var uname = TextEditingController();

  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 140, left: 50, right: 50),
              child: Text(
                "TO DO",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
              child: TextField(
                controller: uname,
                decoration: InputDecoration(
                    hintText: "Username",
                    labelText: "Username",
                    prefixIcon: Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
              child: TextField(
                controller: pass,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.password,
                    color: primaryColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ElevatedButton(
                  onPressed: () async {
                    final userlist = await DBFunction.instance.getUser();
                    findUser(userlist);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.transparent)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 123, right: 123),
              child: Row(
                children: [
                  Text(
                    "Not a user ? ",
                    style: TextStyle(fontSize: 15, color: primaryColor),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signuphive()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> findUser(List<User> userlist) async {
    final email = uname.text.trim();
    final password = pass.text.trim();

    bool userFound = false;
    final validate = await validatelogin(email, password);

    if (validate == true) {
      await Future.forEach(userlist, (user) {
        if (user.email == email && user.password == password) {
          userFound = true;
        } else {
          userFound = false;
        }
      });
      if (userFound == true) {
        Get.offAll(() => MyApp() );
        Get.snackbar("Success", "Login success", backgroundColor: Colors.green);
      } else {
        Get.snackbar("Error", "Incorrect email/password",
            backgroundColor: Colors.red);
      }
    }
  }

  Future<bool> validatelogin(String email, String password) async {
    if (email != "" && password != "") {
      return true;
    } else {
      Get.snackbar("title", "message");
    }
    return false;
  }
}
