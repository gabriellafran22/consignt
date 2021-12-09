import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/screen/category/category_detail_screen.dart';
import 'package:consignt/screen/category/category_screen.dart';
import 'package:consignt/screen/favorite/favorite_screen.dart';
import 'package:consignt/screen/forgot_password/forgot_password.dart';
import 'package:consignt/screen/home/home_screen.dart';
import 'package:consignt/screen/init/init_screen.dart';
import 'package:consignt/screen/login/login_screen.dart';
import 'package:consignt/screen/product/add_product/add_product_screen.dart';
import 'package:consignt/screen/product/detail_product/detail_product_screen.dart';
import 'package:consignt/screen/product/edit_product/edit_product_screen.dart';
import 'package:consignt/screen/profile/profile_screen.dart';
import 'package:consignt/screen/register/register_screen.dart';
import 'package:consignt/screen/search/search/search_screen.dart';
import 'package:consignt/screen/search/search_result/search_result_screen.dart';
import 'package:consignt/screen/settings/about/about_screen.dart';
import 'package:consignt/screen/settings/contact_us/contact_us_screen.dart';
import 'package:consignt/screen/settings/rekber_request/rekber_request_screen.dart';
import 'package:consignt/screen/settings/settings_screen.dart';
import 'package:consignt/screen/shipping/shipping_screen.dart';
import 'package:consignt/screen/splash_screen.dart';
import 'package:consignt/screen/store/create_store/create_store_screen.dart';
import 'package:consignt/screen/store/edit_store/edit_store_screen.dart';
import 'package:consignt/screen/store/my_store/my_store_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  var args = (settings.arguments ?? {}) as Map;
  switch (settings.name) {
    case '/':
      return buildRoute(settings, const SplashScreen());
    case ScreenConst.login:
      return buildRoute(settings, const LoginScreen());
    case ScreenConst.register:
      return buildRoute(settings, const RegisterScreen());
    case ScreenConst.forgotPassword:
      return buildRoute(settings, const ForgotPasswordScreen());
    case ScreenConst.init:
      return buildRoute(settings, const InitScreen());
    case ScreenConst.home:
      return buildRoute(settings, const HomeScreen());
    case ScreenConst.favorite:
      return buildRoute(settings, const FavoriteScreen());
    case ScreenConst.shipping:
      return buildRoute(settings, const ShippingScreen());
    case ScreenConst.settings:
      return buildRoute(settings, const SettingsScreen());
    case ScreenConst.profile:
      return buildRoute(settings, const ProfileScreen());
    case ScreenConst.myStore:
      return buildRoute(settings, const MyStoreScreen());
    case ScreenConst.createStore:
      return buildRoute(settings, const CreateStoreScreen());
    case ScreenConst.editStore:
      return buildRoute(
          settings,
          EditStoreScreen(
            userId: args['userId'],
          ));
    case ScreenConst.addProduct:
      return buildRoute(settings, const AddProductScreen());
    case ScreenConst.editProduct:
      return buildRoute(
        settings,
        EditProductScreen(
          productId: args['productId'],
        ),
      );
    case ScreenConst.detailProduct:
      return buildRoute(
        settings,
        DetailProductScreen(
          productId: args['productId'],
        ),
      );
    case ScreenConst.about:
      return buildRoute(settings, const AboutScreen());
    case ScreenConst.rekBerRequest:
      return buildRoute(settings, const RekBerRequestScreen());
    case ScreenConst.contactUs:
      return buildRoute(settings, const ContactUsScreen());
    case ScreenConst.searchScreen:
      return buildRoute(settings, const SearchScreen());
    case ScreenConst.searchResultScreen:
      return buildRoute(
          settings,
          SearchResultScreen(
            searchQueryController: args['searchQueryController'],
          ));
    case ScreenConst.category:
      return buildRoute(settings, const CategoryScreen());
    case ScreenConst.categoryDetail:
      return buildRoute(
          settings,  CategoryDetailScreen(category: args['category']));
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
  @override
  final WidgetBuilder builder;
  @override
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
