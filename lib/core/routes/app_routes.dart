import 'package:flutter/material.dart';
import '../../presentation/authentication/sign_in.dart';
import '../../presentation/authentication/sign_up.dart';
import '../../presentation/authentication/reset_pass.dart';
import '../../presentation/authentication/otp.dart';
import '../../presentation/authentication/set_pass.dart';
import '../../presentation/free/dashboard/bottomNavigationBar/bottom_navigation.dart';
import '../../presentation/splash/splash_screen.dart';

class AppRoutes {
  static const String signInRoute = '/signIn';
  static const String signUpRoute = '/signUp';
  static const String resetPasswordRoute = '/resetPassword';
  static const String otpRoute = '/otp';
  static const String setPasswordRoute = '/setPassword';
  static const String dashboardRoute = '/dashboard';
  static const String splashRoute = '/splash';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPassScreen());
      case otpRoute:
        return MaterialPageRoute(builder: (_) => const OtpScreen());
      case setPasswordRoute:
        return MaterialPageRoute(builder: (_) => const SetPasswordScreen());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavigation());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
