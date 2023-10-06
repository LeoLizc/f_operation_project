import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Intermedio extends StatelessWidget {
  Intermedio({Key? key}) : super(key: key);

  final GameController gameController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    gameController.startGame();

    return Scaffold(
      appBar: AppBar(
        // mostramos el nombre del usuario en el titulo
        title: const Text(
          ' - Intermedio',
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Iniciar el juego en el nivel ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(
              () => Text(
                gameController.level == 0
                    ? 'No disponible...'
                    : gameController.level.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed('/game');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(300.0),
                      // side: BorderSide(width: 2, color: Colors.black),
                    ),
                  ),
                  iconSize: MaterialStateProperty.all(45.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.play_arrow),
                ))
          ],
        ),
      ),
    );
  }
}
