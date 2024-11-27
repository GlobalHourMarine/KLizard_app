import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../utilities/api_manager.dart';
import '../../../../utilities/app_constant.dart';
import '../../../../utilities/helper_class.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  var refText = "";

  @override
  void initState() {
    super.initState();
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.referralList,
      param: null,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        final refData = data["referral_text"] as String;
        refText = refData;

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
        title: const Text("Referral Policy"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Html(
            data: refText,
          ),
        ),
      ),
    );
  }
}
