import 'package:f_operation_project/data/repositories/auth/mock_auth_repository.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:f_operation_project/ui/pages/activity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/authentication/login.dart';

void main() {
  Get.put<AuthRepository>(MockAuthRepository());
  Get.put(AuthenticationUseCase());
  Get.put(GameController());
  Get.put(AuthController());

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
        // GetPage(name: '/activity', page: () => const Activity()),
      ],
    );
  }
}
