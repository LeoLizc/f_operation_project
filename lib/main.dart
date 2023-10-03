import 'package:f_operation_project/dependency_injection.dart';
import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/pages/game/activity.dart';
import 'package:f_operation_project/ui/pages/authentication/registro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/authentication/login.dart';

void main() {
  setupDependencies();

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
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () {
              AuthController authController = Get.find();
              return Obx(() => authController.isAuthenticated
                  ? const ActivityPage()
                  : const Login());
            }),
        GetPage(
            name: '/register',
            page: () => const Registro(
                  key: Key('Registro'),
                ))
      ],
    );
  }
}
