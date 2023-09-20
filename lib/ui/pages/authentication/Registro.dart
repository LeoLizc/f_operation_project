import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => RegistroP();
}

class RegistroP extends State<Registro> {
  final _formulario = GlobalKey<FormState>();
  final _user = TextEditingController();
  final _password1 = TextEditingController();
  final _password2 = TextEditingController();
  final _birthDay = TextEditingController();
  final _birthMonth = TextEditingController();
  final _birthYear = TextEditingController();
  final _grade = TextEditingController();
  final _school = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Registro"),
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
                  key: const ValueKey("UsuarioRegistro"),
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
                //campo en el cual el usuario va a ingresar el grado que cursa
                const SizedBox(height: 20),
                const Text("Ingrese el grado que cursa",
                    style: TextStyle(fontSize: 20)),
                TextFormField(
                  key: const ValueKey("Grado"),
                  controller: _grade,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Grado",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese el grado que cursa";
                    }
                    return null;
                  },
                ),
                //campo en el cual el usuario va a ingresar su colegio
                const SizedBox(height: 20),
                const Text("Ingrese su colegio",
                    style: TextStyle(fontSize: 20)),
                TextFormField(
                  key: const ValueKey("Colegio"),
                  controller: _school,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Colegio",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Por favor ingrese su colegio";
                    }
                    return null;
                  },
                ),
                //campo en el cual el usuario va a ingresar la fecha de nacimiento
                const SizedBox(height: 20),
                // usaremos 3 campos de texto para ingresar la fecha de nacimiento ubicados en una fila
                const Text("Ingrese su fecha de nacimiento",
                    style: TextStyle(fontSize: 20)),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        key: const ValueKey("Dia"),
                        controller: _birthDay,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Dia",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor ingrese el dia";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        key: const ValueKey("Mes"),
                        controller: _birthMonth,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Mes",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor ingrese el mes";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        key: const ValueKey("Año"),
                        controller: _birthYear,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Año",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor ingrese el año";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                //campo en el cual el usuario va a ingresar su contraseña
                const SizedBox(height: 20),
                const Text("Ingrese su contraseña",
                    style: TextStyle(fontSize: 20)),
                TextFormField(
                  key: const ValueKey("Contraseña1"),
                  controller: _password1,
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
                //campo en el cual el usuario va a ingresar su contraseña nuevamente
                const SizedBox(height: 20),
                const Text("Ingrese su contraseña nuevamente",
                    style: TextStyle(fontSize: 20)),
                TextFormField(
                  key: const ValueKey("Contraseña2"),
                  controller: _password2,
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
                    if (value != _password1.text) {
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
                      if (_formulario.currentState!.validate()) {
                        Get.snackbar("Felicidades", "Registro exitoso");
                        authController
                            .register(
                                birthDay: int.parse(_birthDay.text),
                                birthMonth: int.parse(_birthMonth.text),
                                birthYear: int.parse(_birthYear.text),
                                grade: int.parse(_grade.text),
                                school: _school.text,
                                username: _user.text,
                                password: _password1.text)
                            .then((value) {
                          if (value) {
                            Get.offAllNamed('/');
                          }
                        });
                      }
                    },
                    child: const Text("Registro exitoso")),
              ],
            ),
          ),
          // ),
        )));
  }
}
