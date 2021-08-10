import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();
  static NavigationService navigationService = NavigationService._();
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();

  navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
}