
import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:get/get.dart';

//===================================================
// AuthController bindings - This is a class in the GetX package for Flutter that is used to register a AuthController instance as a dependency in a GetX application. This class specifies that the AuthController instance should be lazily created when it's needed, and not before. By registering the AuthController as a dependency, you can easily access it from other parts of your application. | This helps render the code more organized and reusable. |
//===================================================

class AuthBindings extends Bindings {  
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
