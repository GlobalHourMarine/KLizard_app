// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/deposit_Model.dart';
import 'package:klizards/screens/home/settings/deposit/depositSave_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DepositListScreen extends StatefulWidget {
  const DepositListScreen({super.key});

  @override
  State<DepositListScreen> createState() => _DepositListScreenState();
}

class _DepositListScreenState extends State<DepositListScreen> {
  List<DepositDetail> depositList = [];

  @override
  void initState() {
    super.initState();
    serviceGetDepositList();
  }

  List<Map<String, String>> getCardData(DepositDetail detail) {
    return [
      {'title': 'Payment Mode : ', 'value': detail.name},
      {'title': 'UPI ID : ', 'value': detail.text_data},
      {'title': 'Amount : ', 'value': detail.amount},
      {'title': 'Submit Date : ', 'value': detail.createdAt},
      {'title': 'Payment Status : ', 'value': getPaymentStatus(detail.status)},
    ];
  }

  String getPaymentStatus(String status) {
    if (status == '0') {
      return 'Pending';
    } else if (status == '1') {
      return 'Apporved';
    } else if (status == '2') {
      return 'Rejected';
    }
    return "Pending";
  }

  void serviceGetDepositList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.depositList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        depositList = DepositModel.fromJson(data).list;
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
        title: const Text("Deposit List"),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DepositSaveScreen(
                      onOkPressed: () {
                        serviceGetDepositList();
                      },
                    ),
                  ),
                );
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: depositList.length,
        itemBuilder: (context, index) {
          var detail = depositList[index];
          return GestureDetector(
              onTap: () {},
              child:
                  commonCardDesignForListWithData(getCardData(detail), false));
        },
      ),
    );
  }
}
