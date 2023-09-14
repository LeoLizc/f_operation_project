import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Login.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => RegistroP();
}

class RegistroP extends State<Registro> {
  final _Formulario = GlobalKey<FormState>();
  final _User = TextEditingController();
  final _Password1 = TextEditingController();
  final _Password2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Registro"),
        ),
        body: Center(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _Formulario,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //campo en el cual el usuario va a ingresar su usuario
                  const Text("Ingrese su usuario",
                      style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: const ValueKey("UsuarioRegistro"),
                    controller: _User,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuario",
                    ),
                    validator: (Value) {
                      if (Value!.isEmpty) {
                        return "Por favor ingrese su usuario";
                      }
                      return null;
                    },
                  ),

                  //campo en el cual el usuario va a ingresar su contraseña
                  const SizedBox(height: 20),
                  const Text("Ingrese su contraseña",
                      style: TextStyle(fontSize: 20)),
                  TextFormField(
                    key: const ValueKey("Contraseña1"),
                    controller: _Password1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña",
                    ),
                    validator: (Value) {
                      if (Value!.isEmpty) {
                        return "Por favor ingrese su contraseña";
                      }
                      if (Value.length < 8) {
                        return "La contraseña debe tener al menos 8 caracteres";
                      }
                      return null;
                    },
                  ),
                  //campo en el cual el usuario va a ingresar su contraseña nuevamente
                  const SizedBox(height: 20),
                  const Text("Ingrese su contraseña nuevamente",
                      style: TextStyle(fontSize: 20)),
                  TextFormField(
                    key: const ValueKey("Contraseña2"),
                    controller: _Password2,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña",
                    ),
                    validator: (Value) {
                      if (Value!.isEmpty) {
                        return "Por favor ingrese su contraseña";
                      }
                      if (Value.length < 8) {
                        return "La contraseña debe tener al menos 8 caracteres";
                      }
                      if (Value != _Password1.text) {
                        return "Las contraseñas no coinciden";
                      }
                      return null;
                    },
                  ),

                  // Boton de inicio de seccion
                  const SizedBox(height: 10),
                  OutlinedButton(
                      key: const ValueKey("Registrar"),
                      onPressed: () {
                        if (_Formulario.currentState!.validate()) {
                          Get.snackbar("Felicidades", "Registro exitoso");
                        }
                      },
                      child: const Text("Registro exitoso")),
                ],
              ),
            ),
          ),
        )));
  }
}
