import 'package:f_operation_project/domain/models/user.dart';
import 'package:hive/hive.dart';

class HiveUserDataSource {
  Future<bool> usuarioactual(User usuario) async {
    final box = await Hive.openBox('DatodbAdapter');
    final user = User(
        id: usuario.id,
        username: usuario.username,
        birthDate: usuario.birthDate,
        grade: usuario.grade,
        school: usuario.school,
        difficultyLevel: usuario.difficultyLevel);
    box.add(user);

    return true;
  }

  //funcion para obtener el usuario actual
  Future<User> getUsuarioActual() async {
    final box = await Hive.openBox('DatodbAdapter');
    final user = box.getAt(0) as User;
    await box.close();

    return user;
  }

  Future<bool> actualizarUsuarioActual(User usuario) async {
    final box = await Hive.openBox('DatodbAdapter');
    final user = User(
        id: usuario.id,
        username: usuario.username,
        birthDate: usuario.birthDate,
        grade: usuario.grade,
        school: usuario.school,
        difficultyLevel: usuario.difficultyLevel);
    box.putAt(0, user);
    await box.close();

    return true;
  }

  Future<bool> eliminarUsuarioActual() async {
    final box = await Hive.openBox('DatodbAdapter');
    box.deleteAt(0);

    await box.close();

    return true;
  }
}
