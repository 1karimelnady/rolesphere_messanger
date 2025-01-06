import 'package:get/get.dart';
import 'package:rolesphere_messenger/features/auth_features/view/screens/login_screen.dart';

import 'package:rolesphere_messenger/routes/app_routes.dart';
import 'package:rolesphere_messenger/splash_screen.dart';

class AppPages {
  static const initial = Routes.splash;

  appPages() => [
        GetPage(
          name: Routes.splash,
          page: () => SplashScreen(),
          // binding: LoginBinding(),
        ),
        GetPage(
          name: Routes.login,
          page: () => LoginScreen(),
          // binding: LoginBinding(),
        ),
        // GetPage(
        //   name: Routes.changeLanguageScreen,
        //   page: () => ChangeLanguageScreen(),
        // ),
        // GetPage(
        //   name: Routes.languagePicker,
        //   page: () => LanguageScreen(),
        // ),
      ];
}
