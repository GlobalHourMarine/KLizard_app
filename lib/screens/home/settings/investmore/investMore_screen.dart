// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/paymentMode_model.dart';
import 'package:klizards/screens/home/settings/investmore/paymentModeDetail_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class InvestMoreScreen extends StatefulWidget {
  const InvestMoreScreen({super.key});

  @override
  State<InvestMoreScreen> createState() => _InvestMoreScreenState();
}

class _InvestMoreScreenState extends State<InvestMoreScreen> {
  List<PaymentDetail> paymentModeList = [];

  @override
  void initState() {
    super.initState();
    serviceGetPaymentModeList();
  }

  void serviceGetPaymentModeList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.paymentModeList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        paymentModeList = PaymentModeModel.fromJson(data).list;
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  List<Map<String, String>> getCardData(String title) {
    return [
      {'title': '', 'value': title},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Invest More"),
      ),
      body: ListView.builder(
        itemCount: paymentModeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: commonCardDesignForListWithData(
              getCardData(paymentModeList[index].name),
              true,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentModeDetailScreen(
                    paymentDetail: paymentModeList[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
