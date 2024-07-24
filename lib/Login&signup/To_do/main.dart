import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivetodo/Login&signup/To_do/pages/main_page.dart';
import '../model/usermodel.dart';
import 'constants.dart';
import 'models/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('tasksBox');
  Hive.openBox<User>('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: primaryColor,
          useMaterial3: true,
          textTheme: TextTheme(
              displayLarge: GoogleFonts.dmSans(
                  fontSize: 32, fontWeight: FontWeight.bold, color: darkBlue),
              displayMedium: GoogleFonts.dmSans(
                  fontSize: 28, fontWeight: FontWeight.bold, color: darkBlue),
              titleLarge: GoogleFonts.dmSans(
                  fontSize: 24, fontWeight: FontWeight.bold, color: darkBlue),
              titleMedium: GoogleFonts.dmSans(
                  fontSize: 20, fontWeight: FontWeight.w500, color: darkBlue),
              bodyMedium: GoogleFonts.dmSans(
                  fontSize: 16, fontWeight: FontWeight.w500, color: darkBlue),
              labelMedium:
                  GoogleFonts.dmSans(fontSize: 14, color: darkGreyColor),
              labelSmall: GoogleFonts.dmSans(
                fontSize: 12,
              )),
          iconTheme: const IconThemeData(size: 28),
          buttonTheme: const ButtonThemeData(
            buttonColor: primaryColor,
            disabledColor: greyColor,
          ),
          bottomSheetTheme: BottomSheetThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
