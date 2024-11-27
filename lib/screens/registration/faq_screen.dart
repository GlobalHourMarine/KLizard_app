import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:klizards/models/faq_model.dart';
import '../../utilities/api_manager.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/helper_class.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<FaqModel> faqList = <FaqModel>[];

  @override
  void initState() {
    super.initState();

    ApiManager.sharedInstance.getRequest(
      url: Api.faqList,
      param: null,
      completionCallback: () {},
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;

        final listData = data["list"] as List<dynamic>;
        faqList.clear();
        faqList
            .addAll(listData.map((e) => FaqModel(e["question"], e["answer"])));

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
        title: const Text("FAQ"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ExpansionTile(
            title: Html(
              data: faqList[index].question,
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            children: [
              Html(
                data: faqList[index].answer,
              )
            ],
          );
        },
        itemCount: faqList.length,
      ),
    );
  }
}
