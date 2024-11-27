import 'dart:async';

import 'package:flutter/material.dart';
import 'package:klizards/main.dart';
import 'package:klizards/models/banner_Model.dart';
import 'package:klizards/screens/registration/faq_screen.dart';
import 'package:klizards/screens/home/review/videos_screen.dart';
import 'package:klizards/screens/registration/forgotPassword_screen.dart';
import 'package:klizards/screens/registration/pptList_screen.dart';
import 'package:klizards/screens/registration/updateList_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/common_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utilities/appRoute_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<BannerDetail> bannerList = [];

  final LoopPageController _pageController = LoopPageController(initialPage: 0);
  Timer? _timer;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    // emailController.text = "GNI5543";
    // passwordController.text = "9015";

    serviceGetBannerList();
  }

  Future launchURL(String urlString) async {
    Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void checkValidations() {
    if (emailController.text.isEmpty) {
      showErrorAlert(context, "Empty Email", "Please enter your email address");
    } else if (passwordController.text.isEmpty) {
      showErrorAlert(context, "Empty Password", "Please enter your password");
    } else {
      serviceLogin();
    }
  }
  //

  void serviceLogin() {
    context.loaderOverlay.show();
    Map<String, String> param = {
      'username': emailController.text,
      'password': passwordController.text
    };

    ApiManager.sharedInstance.postRequest(
      param: param,
      url: Api.login,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;

        prefs.setString('access_token', response['access_token'].toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AppRouteScreen()),
        );
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void serviceGetBannerList() {
    context.loaderOverlay.show();

    Map<String, String> param = {
      'banner_type': "1",
    };

    ApiManager.sharedInstance.getRequest(
      url: Api.bannerList,
      param: param,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        bannerList = BannerModel.fromJson(data).list;
        _startAutoScroll();
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RichText(
                  text: const TextSpan(
                      text: "Login to ",
                      style:
                          TextStyle(color: AppColors.blackColor, fontSize: 25),
                      children: [
                    TextSpan(
                        text: "Globle Hour Marine",
                        style: TextStyle(
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w600))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                const Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("App Version 1.0"),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                textfieldCommonNew('Enter Email/Username', Icons.email_outlined,
                    emailController),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 0.3),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          obscureText: obscureText,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.themeColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                          AppColors.themeColor, // Set the button's text color
                    ),
                    child: const Text('Forgot Password'),
                  ),
                ),
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
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: AspectRatio(
                  aspectRatio: 10 / 4,
                  child: LoopPageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: bannerList.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        bannerList[index].path,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ),
            getSocialsSection(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: boxWithIconTitle(
                              "Cellular", "icon_support.png", 90, () {
                            makePhoneCall(App().phoneNumber);
                          }),
                        ),
                        Expanded(
                          child:
                              boxWithIconTitle("PDF", "icon_ppt.png", 90, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PptListScreen(),
                              ),
                            );
                          }),
                        ),
                        Expanded(
                          child: boxWithIconTitle(
                              "Browse", "icon_browse.png", 90, () {
                            launchURL(App().websiteLink);
                          }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        getImageWithPath("icon_bottombar_bg.png"),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      bottomBar("Video", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VideoScreen(),
                          ),
                        );
                      }),
                      bottomBar("Update", () {
                        //launchURL(updates_url);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdateListScreen(),
                          ),
                        );
                      }),
                      bottomBar("Enquiry", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaqScreen(),
                          ),
                        );
                      }),
                      bottomBar("Locate", () {
                        launchURL(App().googleLocationLink);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget getSocialsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: getSocialDesign('icon_facebook.png', () {
            launchURL(App().facebookLink);
          }),
        ),
        Expanded(
          child: getSocialDesign('icon_instagram.png', () {
            launchURL(App().instagramLink);
          }),
        ),
        Expanded(
          child: getSocialDesign('icon_youtube.png', () {
            launchURL(App().youtubeLink);
          }),
        ),
        Expanded(
          child: getSocialDesign('icon_linkedin.png', () {
            launchURL(App().linkedinLink);
          }),
        )
      ],
    );
  }

  Widget getSocialDesign(String iconName, Function callback) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Image.asset(
        getImageWithPath(iconName),
        fit: BoxFit.cover,
        height: 80,
      ),
    );
  }
}

Widget bottomBar(String title, Function callback) {
  return TextButton(
    onPressed: () {
      callback();
    },
    style: TextButton.styleFrom(),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.themeColor,
          ),
        ), // Text
      ],
    ),
  );
}
