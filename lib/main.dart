import 'package:app_provider/app/model/user.dart';
import 'package:flutter/material.dart';
import 'mainpage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mainpage(user: User.user())
        // initialRoute: "/",
        // onGenerateRoute: AppRoute.onGenerateRoute,  -> su dung auto route (pushName)
    );
  }
}
