import 'package:f_operation_project/data/repositories/auth/memory_auth_repository.dart';
import 'package:f_operation_project/data/repositories/session/hive_session_repo.dart';
import 'package:f_operation_project/data/repositories/user/hive_user_repo.dart';
import 'package:f_operation_project/data/repositories/user/retool_user_repo.dart';
import 'package:f_operation_project/domain/repositories/auth_repositoy.dart';
import 'package:f_operation_project/domain/repositories/session_repository.dart';
import 'package:f_operation_project/domain/repositories/user_repository.dart';
import 'package:f_operation_project/domain/use_cases/authentication_usecase.dart';
import 'package:f_operation_project/domain/use_cases/game_usecases.dart';
import 'package:f_operation_project/ui/controllers/auth_controller.dart';
import 'package:f_operation_project/ui/controllers/game_controller.dart';
import 'package:get/get.dart';

void setupDependencies() {
  // Repositorios
  Get.put<UserRepository>(RetoolUserRepository());
  Get.put<AuthRepository>(MemoryAuthRepository());
  Get.put<SessionRepository>(HiveSessionRepository());

  // Casos de uso
  Get.put<AuthenticationUseCase>(AuthenticationUseCase(
      userRepository: Get.find<UserRepository>(),
      authRepository: Get.find<AuthRepository>()));
  Get.put<GameUseCase>(GameUseCase(
      userRepository: Get.find<UserRepository>(),
      sessionRepository: Get.find<SessionRepository>(),
      authRepository: Get.find<AuthRepository>()));

  // Controladores de presentación
  Get.put<AuthController>(AuthController(Get.find<AuthenticationUseCase>()));
  Get.put<GameController>(GameController(Get.find<GameUseCase>()));
}
