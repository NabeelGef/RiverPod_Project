import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_project/CartPage/cartpage.dart';
import 'package:riverpod_project/LoginPage/loginpage.dart';
import 'package:riverpod_project/ProdutcDetailPage/detail.dart';
import 'package:riverpod_project/SettingsPage/settings.dart';

import 'HomePage/home.dart';
import 'RegisterPage/registerpage.dart';

class FLuroRouter {
  static FluroRouter router = FluroRouter();
  static Handler _homePage = Handler(
    handlerFunc: (context, Map<String, dynamic> parameters) {
      return HomePage();
    },
  );
  static Handler _loginPage = Handler(
    handlerFunc: (context, parameters) {
      return LoginPage();
    },
  );
  static Handler _registerPage = Handler(
    handlerFunc: (context, parameters) {
      return RegisterPage();
    },
  );
  static Handler _cartPage = Handler(
    handlerFunc: (context, parameters) {
      return CartPage();
    },
  );
  static Handler _settingPage = Handler(
    handlerFunc: (context, parameters) {
      return SettingsPage();
    },
  );
  static void setupRouter() {
    router.define(
      '/home',
      handler: _homePage,
    );
    router.define('/cart', handler: _cartPage);
    router.define('/login', handler: _loginPage);
    router.define('/register', handler: _registerPage);
    router.define('/settings', handler: _settingPage);
  }
}
