import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:klizards/main.dart';
import 'package:klizards/utilities/appRoute_screen.dart';
import 'package:klizards/screens/registration/login_screen.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/customAlert_screen.dart';

//App

bool isUserLoggedIn() {
  String? token = prefs.getString("access_token");
  return token != null && token.isNotEmpty;
}

getInitialRootWidget() {
  if (isUserLoggedIn()) {
    return const AppRouteScreen();
  } else {
    return const LoginScreen();
  }
}

String getImageWithPath(String imageName) {
  return 'assets/images/$imageName';
}

bool validateEmail(String email) {
  final emailRegExp =
      RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,3})$');
  return emailRegExp.hasMatch(email);
}

String getSharableLink() {
  if (Platform.isIOS) {
    return App().iosLink;
  } else {
    return App().androidLink;
  }
}

void showErrorAlert(BuildContext context, String title, String description) {
  if (description.toLowerCase().contains("expire")) {
    description = 'Your session has expired. Please log in again.';
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: App().appName,
        message: description,
        onConfirmPressed: () {
          Navigator.of(context).pop();
          if (description.contains('session has expired')) {
            prefs.remove("access_token");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        isShowOkSection: true,
      );
    },
  );
}

void showErrorAlertWithOkCallback(BuildContext context, String title,
    String description, Function() okCallback) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: App().appName,
          message: description,
          onConfirmPressed: () {
            okCallback();
            Navigator.of(context).pop();
          },
          isShowOkSection: true,
        );
      });
}

void showCustomAlert(BuildContext context, String title, String description,
    Function() okCallback) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: App().appName,
        message: 'Do you want to Logout?',
        onConfirmPressed: () {
          Navigator.of(context).pop();
          okCallback();
        },
        isShowOkSection: false,
      );
    },
  );
}

void showLoader() {
  EasyLoading.show();
}

void hideLoader() {}
