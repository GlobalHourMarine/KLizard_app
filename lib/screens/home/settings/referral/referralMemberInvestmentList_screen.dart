// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/investment_Model.dart';
import 'package:klizards/screens/home/settings/referral/memberInvestmentDetail.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ReferralMemberInvestmentListScreen extends StatefulWidget {
  final String userID;

  const ReferralMemberInvestmentListScreen({super.key, required this.userID});

  @override
  State<ReferralMemberInvestmentListScreen> createState() =>
      _ReferralMemberInvestmentListScreenState();
}

class _ReferralMemberInvestmentListScreenState
    extends State<ReferralMemberInvestmentListScreen> {
  List<InvestmentDetail> investmentList = [];

  @override
  void initState() {
    super.initState();
    serviceGetMemberInvestmentList();
  }

  List<Map<String, String>> getCardData(InvestmentDetail detail, int index) {
    return [
      {'title': 'Cycle $index : ', 'value': detail.amount},
      {'title': 'Associate Date : : ', 'value': detail.startDate},
      {'title': 'Profit Start Date : ', 'value': detail.returnDate},
      {'title': 'Profit Percentage : ', 'value': '${detail.returnAmount}%'},
    ];
  }

  void serviceGetMemberInvestmentList() {
    context.loaderOverlay.show();

    Map<String, String> params = {
      "user_id": widget.userID,
    };

    ApiManager.sharedInstance.getRequest(
      url: Api.referralMemberInvestmentList,
      param: params,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Member Cycle List"),
      ),
      body: ListView.builder(
        itemCount: investmentList.length,
        itemBuilder: (context, index) {
          var detail = investmentList[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MemberInvestmentDetail(
                            cycleID: detail.id, docPath: detail.docPath)));
              },
              child: commonCardDesignForListWithData(
                getCardData(detail, investmentList.indexOf(detail) + 1),
                true,
              ));
        },
      ),
    );
  }
}
