// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final bool isShowOkSection;

  final Function onConfirmPressed;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.isShowOkSection,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    print(title);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 205),
              Color.fromARGB(255, 251, 215, 171),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppColors.colorGradienDarkMehroon,
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(
                    getImageWithPath('1.png'),
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.colorGradienDarkMehroon,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),

            const SizedBox(height: 30.0),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black,
            ),
            Expanded(
                child: isShowOkSection == true
                    ? getOkButtonSection(context)
                    : getYesNoButtonSection(context)),
          ],
        ),
      ),
    );
  }

  Widget getYesNoButtonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            onConfirmPressed();
          },
          child: const Text(
            '        Yes        ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: AppColors.colorGradienDarkMehroon,
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: 1,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            '        No        ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: AppColors.colorGradienDarkMehroon,
            ),
          ),
        ),
      ],
    );
  }

  Widget getOkButtonSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            onConfirmPressed();
          },
          child: const Text(
            '        OK        ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              color: AppColors.colorGradienDarkMehroon,
            ),
          ),
        ),
      ],
    );
  }
}
