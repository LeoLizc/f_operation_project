import 'package:f_operation_project/domain/models/operation.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:f_operation_project/ui/widgets/numpad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

    controller.startGame();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
          actions: [
            Obx(() => Row(
                  children: [
                    const Text('Score: ', style: const TextStyle(fontSize: 20)),
                    Text(controller.score.toString(),
                        style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 20),
                  ],
                ))
          ],
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
                      'Cargando operaciones...',
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
                    var lastOperation = controller.operation!;

                    controller.answer(int.parse(p0)).then((value) async {
                      if (lastOperation.resultado != int.parse(p0)) {
                        await AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Fallaste",
                          desc: "La respuesta es incorrecta",
                          // // actions to perform on cancel and ok buttons
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.red,
                        ).show();
                      } else {
                        await AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.topSlide,
                          showCloseIcon: true,
                          title: "Correcto",
                          desc: "La respuesta es correcta",
                          // // actions to perform on cancel and ok buttons
                          btnOkOnPress: () {},
                          btnOkIcon: Icons.cancel,
                          btnOkColor: Colors.blue,
                        ).show();
                      }

                      if (value) {
                        Get.back(closeOverlays: true);
                      }

                      // AwesomeDialog
                    });
                  },
                ),
                // const SizedBox(height: 2),
              ],
            )));
  }
}
