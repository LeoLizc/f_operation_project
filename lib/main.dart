import 'package:f_operation_project/dependency_injection.dart';
import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/pages/authentication/registro.dart';
import 'package:f_operation_project/ui/pages/game/activity.dart';
import 'package:f_operation_project/ui/pages/game/intermedio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/datasources/Local/model_session.dart';
import 'data/datasources/Local/model_user.dart';
import 'ui/pages/authentication/login.dart';

Future<List<Box>> _openBox() async {
  List<Box> boxes = [];
  await Hive.initFlutter();
  Hive.registerAdapter(DatodbAdapter());
  boxes.add(await Hive.openBox('DatodbAdapter'));
  return boxes;
}

Future<List<Box>> _openBox2() async {
  List<Box> boxes = [];
  await Hive.initFlutter();
  Hive.registerAdapter(DatodbsessionAdapter());
  boxes.add(await Hive.openBox('Dato_db_session'));
  return boxes;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
  await _openBox2();
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
                  ? Intermedio()
                  : const Login());
            }),
        GetPage(
          name: '/register',
          page: () => const Registro(
            key: Key('Registro'),
          ),
        ),
        GetPage(
          name: '/game',
          page: () => const ActivityPage(
            key: Key('ActivityPage'),
          ),
        ),
      ],
    );
  }
}
