// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/percentage_Model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PercentageListScreen extends StatefulWidget {
  const PercentageListScreen({super.key});

  @override
  State<PercentageListScreen> createState() => _PercentageListScreenState();
}

class _PercentageListScreenState extends State<PercentageListScreen> {
  List<PercentageModel> percentageList = [];

  @override
  void initState() {
    super.initState();
    serviceGetPercentageList();
  }

  void serviceGetPercentageList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.percentageDetail,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        percentageList = (response["data"] as List<dynamic>)
            .map((e) => PercentageModel.fromJson(e as Map<String, dynamic>))
            .toList();
        setState(() {});
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
        title: const Text("Percentage List"),
      ),
      body: ListView.builder(
        itemCount: percentageList.length,
        itemBuilder: (context, index) {
          var detail = percentageList[index];
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
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
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        detail.amount.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
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
                      child: Text(
                        detail.percent.toString(),
                        style: const TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
