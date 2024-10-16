import 'package:flutter/material.dart';
import 'package:indrajala/features/auth/presentation/login_screen.dart';
import 'package:indrajala/features/auth/presentation/passwordreset_screen.dart';
import 'package:indrajala/features/auth/presentation/signup_screen.dart';
import 'package:indrajala/features/home/presentation/homescreen.dart';
import 'package:indrajala/features/profile/presentation/presentation/profile.dart';
import 'package:indrajala/features/splash/presentation/splash_screen.dart';
import 'package:indrajala/features/subscription/presentation/subscription_screen.dart';

class IAppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String passwordReset = '/passwordReset';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String subScription = '/subScription'; 
  static const String subScriptionDetailPage = '/subScriptionDetailPage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case passwordReset:
        return MaterialPageRoute(builder: (_) => PasswordResetScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreenTest());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case subScription:
        return MaterialPageRoute(builder: (_) => const SubscriptionPage());
      case subScriptionDetailPage:
        // return MaterialPageRoute(
        //     builder: (_) =>  SubscriptionDetailPage());
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
