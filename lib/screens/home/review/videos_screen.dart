import 'package:flutter/material.dart';
import 'package:klizards/models/feed_Model.dart';
import 'package:klizards/screens/home/review/videoPlayer_screen.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:loader_overlay/loader_overlay.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<FeedDetail> feedList = [];

  @override
  void initState() {
    super.initState();
    serviceGetFeedList();
  }

  void serviceGetFeedList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.videoList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        feedList = FeedModel.fromJson(data).list;
        getYouTubeThumbnails(); // Fetch YouTube thumbnails
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  Future<void> getYouTubeThumbnails() async {
    for (var feed in feedList) {
      try {
        final videoId = extractVideoId(feed.videoLink);
        ;
        print('Video ID: $videoId');
        final Uri uri = Uri.https('youtube.com', 'watch', {'v': '$videoId'});
        if (uri == null) {
          return null;
        }
        final thumbnailUrl =
            "https://img.youtube.com/vi/${uri.queryParameters['v']}/mqdefault.jpg";

        "https://img.youtube.com/vi/$videoId/mqdefault.jpg";
        // print('Thumbnail URL: $thumbnailUrl');
        // feed.thumbnailUrl = thumbnailUrl;
      } catch (error) {
        // print('Error fetching thumbnail: $error');
        feed.thumbnailUrl = ""; // Set thumbnailUrl to empty if an error occurs
      }
    }
  }

  String extractVideoId(String videoLink) {
    final regExp = RegExp(r"youtube\.com\/watch\?v=([a-zA-Z0-9_-]+)");
    final match = regExp.firstMatch(videoLink);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
    throw "Invalid YouTube video link";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Us"),
      ),
      body: ListView.builder(
        itemCount: feedList.length,
        itemBuilder: (context, index) {
          var detail = feedList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerScreen(videoId: detail.videoLink),
                ),
              );
            },
            child: SizedBox(
              height: 120,
              child: CardWidget(
                title: detail.title,
                videoLink: detail.videoLink,
                thumbnailUrl: detail.thumbnailUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String videoLink;
  final String thumbnailUrl;

  CardWidget({
    Key? key,
    required this.title,
    required this.videoLink,
    required this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image.network(
              thumbnailUrl.isNotEmpty
                  ? thumbnailUrl
                  : 'https://img.youtube.com/vi/$videoLink/mqdefault.jpg',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 20,
            ),
            Center(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
