// ignore_for_file: file_names

import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginP();
}

class LoginP extends State<Login> {
  final _formulario = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _password = TextEditingController();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Login"),
        ),
        body: Center(
            // child: Container(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formulario,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //campo en el cual el usuario va a ingresar su usuario
                const Text("Ingrese su usuario",
                    style: TextStyle(fontSize: 20)),
                TextFormField(
                  key: const ValueKey("Usuario"),
                  controller: _user,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Usuario",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
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
                  key: const ValueKey("Contraseña"),
                  obscureText: true,
                  controller: _password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Contraseña",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese su contraseña";
                    }
                    if (value.length < 8) {
                      return "La contraseña debe tener al menos 8 caracteres";
                    }
                    return null;
                  },
                ),
                // Boton de inicio de seccion
                const SizedBox(height: 10),
                OutlinedButton(
                    key: const ValueKey("Iniciar"),
                    onPressed: () {
                      if (_formulario.currentState!.validate()) {
                        authController
                            .login(_user.text, _password.text)
                            .then((value) {
                          if (value) {
                            // Get.snackbar("Bienvenido", "Iniciando seccion");
                          } else {
                            // Get.snackbar(
                            //     "Error", "Usuario o contraseña incorrectos");
                          }
                        });
                      }
                    },
                    child: const Text("Iniciar seccion")),
                // Boton de registro
                const SizedBox(height: 10),
                OutlinedButton(
                    key: const ValueKey("Registrarse"),
                    onPressed: () {
                      Get.toNamed('register');
                    },
                    child: const Text("Registrarse")),
              ],
            ),
          ),
          // ),
        )));
  }
}
