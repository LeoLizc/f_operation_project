import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:f_operation_project/ui/widgets/numpad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

    controller.startGame();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 48, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const SizedBox(height: 2),
                Obx(() {
                  // return Text('Hola');
                  if (controller.operation == null) {
                    return const Text(
                      'No hay operaciones',
                      style: TextStyle(fontSize: 37),
                    );
                  }

                  Operation operation = controller.operation!;

                  return Text(
                      key: UniqueKey(),
                      '${operation.operando1} ${operation.operador} ${operation.operando2} = ?',
                      style: const TextStyle(fontSize: 37));
                }),
                NumpadInput(
                  key: UniqueKey(),
                  onGoPressed: (p0) {
                    controller.answer(int.parse(p0));
                  },
                ),
                // const SizedBox(height: 2),
              ],
            )));
  }
}
