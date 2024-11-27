// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/investment_Model.dart';
import 'package:klizards/utilities/app_constant.dart';

class CallUsScreen extends StatefulWidget {
  const CallUsScreen({super.key});

  @override
  State<CallUsScreen> createState() => _CallUsScreenState();
}

class _CallUsScreenState extends State<CallUsScreen> {
  List<InvestmentDetail> investmentList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    App().phoneNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "admin@klizards.com",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 25,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.themeColor, // Border color
                            width: 2.0,
                          )),
                      child: const Text(
                        "Contact Us",
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                //mne
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.themeColor,
                              AppColors.themeColor,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(
                                    Icons.share_location_sharp,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Unit No 29-30 B",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "3rd Floor Motia Royal",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Buisness Park",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Zirakpur, 140603",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // ],
                        ),
                      ),
                    ),
                  ),
                  //   ),
                  Positioned(
                    top: 5,
                    left: 25,
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.themeColor, // Border color
                            width: 2.0,
                          )),
                      child: const Text(
                        "Visit Us",
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.themeColor,
                              AppColors.themeColor,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Icon(
                                    Icons.alarm_add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "9 AM to 6 PM",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 3),
                              Text(
                                "(Monday to Saturday)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          // ],
                        ),
                      ),
                    ),
                  ),
                  //   ),
                  Positioned(
                    top: 5,
                    left: 25,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: AppColors.themeColor, // Border color
                            width: 2.0,
                          )),
                      child: const Text(
                        "Working Hours",
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
