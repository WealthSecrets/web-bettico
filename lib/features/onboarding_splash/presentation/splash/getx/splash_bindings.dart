import 'package:betticos/features/auth/domain/usecases/is_authenticated.dart';
import 'package:get/get.dart';

import '/features/auth/domain/usecases/validate_session.dart';
import '/features/onboarding_splash/domain/usecases/get_onboard.dart';
import '/features/onboarding_splash/presentation/splash/getx/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(
        getOnBoard: GetOnBoard(
          onBoardRepository: Get.find(),
        ),
        validateSession: ValidateSession(
          authRepository: Get.find(),
        ),
        isAuthenticated: IsAuthenticated(
          authRepository: Get.find(),
        ),
      ),
    );
  }
}
