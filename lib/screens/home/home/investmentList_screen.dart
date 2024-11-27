// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/investment_Model.dart';
import 'package:klizards/screens/home/home/statement_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class InvestmentListScreen extends StatefulWidget {
  final Function()? backCallback;
  const InvestmentListScreen({this.backCallback, super.key});

  @override
  State<InvestmentListScreen> createState() => _InvestmentListScreenState();
}

class _InvestmentListScreenState extends State<InvestmentListScreen> {
  List<InvestmentDetail> investmentList = [];
  bool iscycledetail = false;
  var id = '';
  var docPath = '';

  @override
  void initState() {
    super.initState();
    serviceGetInvestmentList();
  }

  List<Map<String, String>> getCardData(InvestmentDetail detail, int index) {
    return [
      {'title': 'Cycle $index : ', 'value': detail.amount},
      {'title': 'Associate Date : : ', 'value': detail.startDate},
      {'title': 'Profit Start Date : ', 'value': detail.returnDate},
      {'title': 'Profit Percentage : ', 'value': '${detail.returnAmount}%'},
    ];
  }

  void serviceGetInvestmentList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.investmentList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        investmentList = InvestmentModel.fromJson(data).list;
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return iscycledetail
        ? StatementScreen(
            cycleID: id,
            docPath: docPath,
            backCallback: () {
              setState(() {
                iscycledetail = false;
              });
            },
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Cycle List"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context); // widget.backCallback?.call();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: ListView(
              children: investmentList.map((detail) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      iscycledetail = true;
                      id = detail.id;
                      docPath = detail.docPath;
                    });
                  },
                  child: commonCardDesignForListWithData(
                    getCardData(detail, investmentList.indexOf(detail) + 1),
                    true,
                  ),
                );
              }).toList(),
            ),
          );
  }
}
