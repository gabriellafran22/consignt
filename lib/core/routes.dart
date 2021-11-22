import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/screen/about/about_screen.dart';
import 'package:consignt/screen/detail_product/detail_product_screen.dart';
import 'package:consignt/screen/home/home_screen.dart';
import 'package:consignt/screen/login/login_screen.dart';
import 'package:consignt/screen/register/register_screen.dart';
import 'package:consignt/screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  // var args = (settings.arguments ?? {}) as Map;
  switch (settings.name) {
    case '/':
      return buildRoute(settings, const SplashScreen());
    case ScreenConst.login:
      return buildRoute(settings, const LoginScreen());
    case ScreenConst.register:
      return buildRoute(settings, const RegisterScreen());
    case ScreenConst.home:
      return buildRoute(settings, const HomeScreen());
    case ScreenConst.about:
      return buildRoute(settings, const AboutScreen());
    case ScreenConst.detailProduct:
      return buildRoute(settings, const DetailProductScreen());
    default:
      return buildRoute(settings, const SplashScreen());
  }
}

MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
  return CustomPageRoute(
    settings: settings,
    builder: (BuildContext context) => builder,
  );
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  final WidgetBuilder builder;
  final RouteSettings settings;

  CustomPageRoute({
    required this.settings,
    required this.builder,
  }) : super(settings: settings, builder: builder);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return CupertinoPageTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: false,
      child: child,
    );
  }
}
