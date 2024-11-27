import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:klizards/models/banner_Model.dart';
import 'package:klizards/screens/home/home/documents_screen.dart';
import 'package:klizards/screens/home/home/investmentList_screen.dart';
import 'package:klizards/screens/home/settings/percentage_screen.dart';
import 'package:klizards/screens/home/settings/profile_screen.dart';
import 'package:klizards/screens/home/settings/referral/referral_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/common_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BannerDetail> bannerList = [];
  Map<String, dynamic>? detail;

  final LoopPageController _pageController = LoopPageController(initialPage: 0);
  Timer? _timer;
  bool isCheckProfitClicked = false;
  @override
  void initState() {
    super.initState();
    serviceGetBannerList();
    serviceGetProfileData();
    FirebaseMessaging.instance.getToken().then((token) {
      serviceSubmitFirebaseToken(token ?? "");
    });
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  var name = "";
  getScreen() {
    switch (name) {
      case "statement":
        return InvestmentListScreen(
          backCallback: () {
            name = "";
            setState(() {});
          },
        );
      case "profile":
        return ProfileScreen(
          backCallback: () {
            name = "";
            setState(() {});
          },
        );
      default:
        return null;
    }
  }

  void serviceGetBannerList() {
    context.loaderOverlay.show();

    Map<String, String> param = {
      'banner_type': "2",
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

  void serviceSubmitFirebaseToken(String token) {
    context.loaderOverlay.show();

    Map<String, String> param = {
      'device_token': token,
      'device_type': Platform.operatingSystem,
    };

    ApiManager.sharedInstance.postRequest(
      url: Api.deviceInfo,
      param: param,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void serviceGetProfileData() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.profileData,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        detail = data;
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void checkProfit() {
    //showSnackbar(context, 'Checking Profit...');
    isCheckProfitClicked = true;
    setState(() {});
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getScreen() ??
        Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getProfileSection(),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.themeColor,
                                borderRadius: BorderRadius.circular(5)),
                            height: 36,
                            width: 36,
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                makePhoneCall(App().phoneNumber);
                              },
                              child: Text(
                                "${App().phoneNumber}, Please call us for query",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Other rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: boxWithIconTitle(
                                "Statement", "icon_statement.png", 90, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const InvestmentListScreen(),
                                ),
                              ); // setState(() {
                              //   name = "statement";
                              // });
                            }),
                          ),
                          Expanded(
                            child: boxWithIconTitle(
                                "Profile", "icon_profile.png", 90, () {
                              name = "profile";
                              setState(() {});
                            }),
                          ),
                          Expanded(
                            child: boxWithIconTitle(
                                "Documents", "icon_document.png", 90, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DocumentListScreen(),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: boxWithIconTitle(
                                "Referral", "icon_policy.png", 90, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReferralScreen(),
                                ),
                              );
                            }),
                          ),
                          Expanded(
                            child: boxWithIconTitle(
                                "Latest %age", "icon_group.png", 90, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PercentageListScreen(),
                                ),
                              );
                            }),
                          ),
                          Expanded(
                            child: boxWithIconTitle(
                                "Share", "icon_share.png", 90, () {
                              Share.share(getSharableLink());
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      // Banner container
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, width: 0.5), // Border
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: AspectRatio(
                          aspectRatio: 10 / 5,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }

  Widget getProfileSection() {
    return Card(
      elevation: 5.0,
      color: const Color.fromARGB(255, 21, 20, 20),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Stack(
        children: [
          Image.asset(
            getImageWithPath("icon_cardBackground.png"),
            height: 240,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi,${detail?["name"].toString() ?? ""}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Global Hour Marine  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Image.asset(
                          getImageWithPath('1.png'),
                          width: 30,
                          height: 30,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Account Number",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        "A/C  ${detail?['account_number'].toString() ?? "0000000000000000"}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Associate Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Rs ${detail?['investment_amount'].toString() ?? "00000"}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isCheckProfitClicked == true)
                        const Text(
                          "Profit Amount",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      if (isCheckProfitClicked == true)
                        Text(
                          'Rs ${detail?['profit_amount'].toString() ?? "00000"}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (isCheckProfitClicked == false)
                        ElevatedButton(
                          onPressed: checkProfit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors
                                .white, // Set button background color to white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                              side: const BorderSide(
                                color: AppColors.themeColor, // Border color
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: const Text(
                              'Check Profit',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
