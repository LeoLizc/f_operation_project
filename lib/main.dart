import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/authentication/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'TextFields & Forms',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login(
          key: Key('LoginScreen'),
          email: "blank",
          password: "blank",
        ));
  }
}
