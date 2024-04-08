import 'package:NudgeBuddy/controllers/auth.dart';
import 'package:NudgeBuddy/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'constants/colors.dart';
import 'views/pages/splash/splash.dart';
import 'package:timezone/data/latest.dart' as tz;

// MAIN FUNCTION OF THE APP | RUNS THE APP | INITIALIZE FIREBASE | REQUEST NOTIFICATIONS PERMISSION
// ===================================================================================================
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  // REQUEST NOTIFICATIONS PERMISSION
  await Permission.notification.request();
  runApp(const MyApp());
}

// MAIN WIDGET OF THE APP | SETS THE ORIENTATION OF THE APP | SETS THE FONT FAMILY | SETS THE PRIMARY COLOR | SETS THE BACKGROUND COLOR | SETS THE INITIAL PAGE OF THE APP
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            Get.put(AuthController());
            return GetMaterialApp(
              // initialBinding: AuthBindings(),
              theme: ThemeData(
                  fontFamily: 'Poppins',
                  cupertinoOverrideTheme: const CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(fontFamily: 'Poppins'),
                  )),
                  colorScheme: ThemeData().colorScheme.copyWith(
                        primary: ColorConstants.primaryColor,
                      ),
                  scaffoldBackgroundColor: Colors.white),
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
