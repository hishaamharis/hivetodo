import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivetodo/Login&signup/To_do/main.dart';
import '../To_do/constants.dart';
import '../To_do/models/task.dart';
import '../model/usermodel.dart';


void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');
  Hive.openBox<User>('user');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splash(),
  ));
}

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    super.initState();
    Timer((Duration(seconds: 6)), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 150,
            ),
            child: Icon(
              Icons.task,
              color: primaryColor,
              size: 80,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Task Manager",
            style: TextStyle(
                color: primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 500,
            width: 500,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/2.png"), fit: BoxFit.fill)),
          ),
        ],
      ),
    );
  }
}
