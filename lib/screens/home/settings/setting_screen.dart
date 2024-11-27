import 'package:flutter/material.dart';
import 'package:klizards/main.dart';
import 'package:klizards/screens/home/settings/deposit/depositList_screen.dart';
import 'package:klizards/screens/home/settings/investmore/investMore_screen.dart';
import 'package:klizards/screens/home/settings/referral/referralMemberList_screen.dart';
import 'package:klizards/screens/registration/login_screen.dart';
import 'package:klizards/screens/home/settings/percentage_screen.dart';
import 'package:klizards/screens/home/settings/profile_screen.dart';
import 'package:klizards/screens/home/settings/referral/referral_screen.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String referralPolicyfilePath = 'assets/pdfs/dummy.pdf';

  List<Map<String, dynamic>> settingList = [
    {"icon": "", "title": "Profile"},
    {"icon": "ass", "title": "Invest More"},
    {"icon": "ass", "title": "Deposit List"},
    {"icon": "ass", "title": "Latest Percentage"},
    {"icon": "ass", "title": "Share Link"},
    {"icon": "ass", "title": "Referral Policy"},
    {"icon": "ass", "title": "Referral Members"},
    {"icon": "ass", "title": "Logout"},
  ];

  bool isProfileShownOnHome = false;

  @override
  void initState() {
    super.initState();
  }

  Future launchURL(String urlString) async {
    Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  List<Map<String, String>> getCardData(String title) {
    return [
      {'title': '', 'value': title},
    ];
  }

  void shareText() {
    Share.share(getSharableLink());
  }

  @override
  Widget build(BuildContext context) {
    return isProfileShownOnHome
        ? ProfileScreen(
            backCallback: () {
              isProfileShownOnHome = false;
              setState(() {});
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Menu"),
            ),
            body: ListView.builder(
                itemCount: settingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: commonCardDesignForListWithData(
                          getCardData(settingList[index]["title"]), true),
                      onTap: () {
                        if (index == 0) {
                          isProfileShownOnHome = true;
                          setState(() {});
                        } else if (index == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InvestMoreScreen(),
                              // settings: RouteSettings(arguments: someData),
                            ),
                          );
                        } else if (index == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DepositListScreen(),
                              // settings: RouteSettings(arguments: someData),
                            ),
                          );
                        } else if (index == 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PercentageListScreen(),
                            ),
                          );
                        } else if (index == 4) {
                          shareText();
                        } else if (index == 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReferralScreen(),
                            ),
                          );
                        } else if (index == 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ReferralUserListScreen(),
                            ),
                          );
                        } else if (index == 7) {
                          showCustomAlert(
                              context, 'Alert', "Do you want to logout?", () {
                            prefs.remove("access_token");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          });
                        }
                      });
                }),
          );
  }
}
