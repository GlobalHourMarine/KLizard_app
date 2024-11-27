// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/common_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void checkValidations() {
    if (emailController.text.isEmpty) {
      showErrorAlert(context, "Empty Email", "Please enter your email address");
    } else {
      serviceLogin();
    }
  }
  //

  void serviceLogin() {
    context.loaderOverlay.show();
    Map<String, String> param = {
      'email': emailController.text,
    };

    ApiManager.sharedInstance.postRequest(
      param: param,
      url: Api.forgotPassword,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        showErrorAlert(context, App().appName, response['message'].toString());
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forgot Password"),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              textfieldCommonNew(
                  'Enter Email', Icons.email_outlined, emailController),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: (() {
                    checkValidations();
                  }),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
