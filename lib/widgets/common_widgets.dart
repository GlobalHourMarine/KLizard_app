import 'package:flutter/material.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:url_launcher/url_launcher.dart';

Widget boxWithIconTitle(
    String title, String iconName, double height, void Function() callback) {
  return GestureDetector(
    onTap: () {
      callback();
    },
    child: Container(
      height: height,
      //padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 233, 231, 231),
            Colors.white
          ], // Replace with your desired colors
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: [0.0, 1.0], // Adjust stops as needed
        ),
        // color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(color: Colors.grey, width: 0.3), // Border
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Image.asset(
            getImageWithPath(iconName),
            height: 40,
            width: 40,
            color: AppColors.themeColor,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    ),
  );
}

Widget textfieldCommonNew(
    String placeholder, IconData icon, TextEditingController controller) {
  return Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.grey[200], // Background color
      borderRadius: BorderRadius.circular(10), // Rounded corners
      border: Border.all(color: Colors.grey, width: 0.3), // Border
    ),
    child: Row(
      children: [
        Icon(icon), // Icon on the left
        const SizedBox(width: 8), // Space between icon and text field
        Expanded(
          child: TextField(
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            obscureText: placeholder.contains('Password') ? true : false,
            controller: controller, // Assign the controller
            decoration: InputDecoration(
              border: InputBorder.none, // Hide default TextField border
              hintText: placeholder,
            ),
          ),
        ),
      ],
    ),
  );
}

LinearGradient getAppThemeGradientColor() {
  return const LinearGradient(
    colors: [
      AppColors.colorGradientLightMehroon,
      AppColors.colorGradienDarkMehroon
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}
