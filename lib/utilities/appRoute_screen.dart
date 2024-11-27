// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:klizards/screens/home/settings/setting_screen.dart';
// import 'package:klizards/utilities/app_constant.dart';
// import '../screens/home/callus/callus_screen.dart';
// import '../screens/home/review/videos_screen.dart';
// import '../screens/home/home/home_screen.dart';

// class AppRouteScreen extends StatefulWidget {
//   const AppRouteScreen({super.key});

//   @override
//   State<AppRouteScreen> createState() => _AppRouteScreenState();
// }

// class _AppRouteScreenState extends State<AppRouteScreen> {
//   int _selectedIndex = 0; // To keep track of the selected tab.

//   final List<Widget> _pages = [
//     // Define the pages for each tab here.
//     const HomeScreen(),
//     const VideoScreen(),
//     const CallUsScreen(),
//     const SettingScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(30),
//           bottom: Radius.circular(30),
//         ),
//         child: Container(
//           color: AppColors.themeColor,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//             child: GNav(
//               padding: const EdgeInsets.all(8.0),
//               curve: Curves.bounceOut,
//               backgroundColor: AppColors.themeColor,
//               color: Colors.white,
//               activeColor: AppColors.themeColor,
//               tabBackgroundColor: Colors.white,
//               gap: 8,
//               selectedIndex: _selectedIndex,
//               onTabChange: (index) {
//                 setState(() {
//                   _selectedIndex = index;
//                 });
//               },
//               tabs: const [
//                 GButton(
//                   icon: Icons.home,
//                   text: 'Home',
//                 ),
//                 GButton(
//                   icon: Icons.feed,
//                   text: 'Review',
//                 ),
//                 GButton(
//                   icon: Icons.call,
//                   text: 'Call Us',
//                 ),
//                 GButton(
//                   icon: Icons.settings,
//                   text: 'Settings',
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:klizards/screens/home/settings/setting_screen.dart';
import 'package:klizards/utilities/app_constant.dart';
import '../screens/home/callus/callus_screen.dart';
import '../screens/home/review/videos_screen.dart';
import '../screens/home/home/home_screen.dart';

class AppRouteScreen extends StatefulWidget {
  const AppRouteScreen({super.key});

  @override
  State<AppRouteScreen> createState() => _AppRouteScreenState();
}

class _AppRouteScreenState extends State<AppRouteScreen> {
  int _selectedIndex = 0; // To keep track of the selected tab.

  final List<Widget> _pages = [
    // Define the pages for each tab here.
    const HomeScreen(),
    const VideoScreen(),
    const CallUsScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.circular(30),
        ),
        child: Container(
          color: AppColors.themeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: AppColors.colorGradienDarkMehroon,
              iconSize: 24,
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 100),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.white,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.play_arrow,
                  iconSize: 32,
                  text: 'Review',
                ),
                GButton(
                  icon: Icons.call,
                  text: 'Call Us',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
