// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/ReferralMember_Model.dart';
import 'package:klizards/screens/home/settings/referral/referralMemberInvestmentList_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ReferralUserListScreen extends StatefulWidget {
  const ReferralUserListScreen({super.key});

  @override
  State<ReferralUserListScreen> createState() => _ReferralUserListScreenState();
}

class _ReferralUserListScreenState extends State<ReferralUserListScreen> {
  List<ReferralMemberModel> refrralMemberList = [];

  @override
  void initState() {
    super.initState();
    serviceGetMemberList();
  }

  List<Map<String, String>> getCardData(ReferralMemberModel detail) {
    return [
      {'title': 'User id : ', 'value': detail.userId},
      {'title': 'Name : : ', 'value': detail.name},
      {'title': 'Address : ', 'value': detail.address},
      {'title': 'Email : ', 'value': detail.email},
      {'title': 'Designation : ', 'value': detail.designation},
      {'title': 'Joined date : ', 'value': detail.createdAt},
    ];
  }

  void serviceGetMemberList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.referralMemberList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;

        if (response.containsKey("refferal_members")) {
          final data = response["refferal_members"] as List;
          refrralMemberList = data
              .map((e) =>
                  ReferralMemberModel.fromJson(e as Map<String, dynamic>))
              .toList();
          setState(() {});
        } else {
          showErrorAlert(
              context, App().appName, response['message'].toString());
        }
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
        title: const Text("Members"),
      ),
      body: ListView.builder(
        itemCount: refrralMemberList.length,
        itemBuilder: (context, index) {
          var detail = refrralMemberList[index];
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ReferralMemberInvestmentListScreen(userID: detail.id),
                  ),
                );
              },
              child:
                  commonCardDesignForListWithData(getCardData(detail), true));
        },
      ),
    );
  }
}
