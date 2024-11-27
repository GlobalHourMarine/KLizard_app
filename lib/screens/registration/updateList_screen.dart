// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:klizards/models/news_model.dart';
import '../../utilities/api_manager.dart';
import '../../utilities/app_constant.dart';
import '../../utilities/helper_class.dart';

class UpdateListScreen extends StatefulWidget {
  const UpdateListScreen({super.key});

  @override
  State<UpdateListScreen> createState() => _UpdateListScreenState();
}

class _UpdateListScreenState extends State<UpdateListScreen> {
  final List<NewsModel> newsList = <NewsModel>[];

  @override
  void initState() {
    super.initState();

    ApiManager.sharedInstance.getRequest(
      url: Api.updateList,
      param: null,
      completionCallback: () {},
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final listData = response["data"] as List<dynamic>;
        newsList.clear();
        newsList.addAll(listData.map((e) => NewsModel(e["title"], e["news"])));

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
        title: const Text("News"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ExpansionTile(
            title: Html(
              data: newsList[index].title,
            ),
            childrenPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            children: [
              Html(
                data: newsList[index].news,
              )
            ],
          );
        },
        itemCount: newsList.length,
      ),
    );
  }
}
