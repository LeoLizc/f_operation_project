import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Registro.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;

  @override
  State<Login> createState() => LoginP();
}

class LoginP extends State<Login> {
  final _Formulario = GlobalKey<FormState>();
  final _User = TextEditingController();
  final _Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Login"),
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
                    key: const ValueKey("Usuario"),
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
                    key: const ValueKey("Contraseña"),
                    controller: _Password,
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
                  // Boton de inicio de seccion
                  const SizedBox(height: 10),
                  OutlinedButton(
                      key: const ValueKey("Iniciar"),
                      onPressed: () {
                        if (_Formulario.currentState!.validate()) {
                          Get.snackbar("Bienvenido", "Iniciando seccion");
                        }
                      },
                      child: const Text("Iniciar seccion")),
                  // Boton de registro
                  const SizedBox(height: 10),
                  OutlinedButton(
                      key: const ValueKey("Registrarse"),
                      onPressed: () {
                        Get.to(const Registro(
                          key: Key("Registro"),
                        ));
                      },
                      child: const Text("Registrarse")),
                ],
              ),
            ),
          ),
        )));
  }
}
