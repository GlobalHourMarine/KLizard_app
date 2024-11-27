// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klizards/models/profile_Model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProfileScreen extends StatefulWidget {
  final Function()? backCallback;

  const ProfileScreen({this.backCallback, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileDetail> profileList = [];
  File? galleryImage;
  String username = '';
  String accountNumber = '';
  String profilepicURL = '';

  @override
  void initState() {
    super.initState();
    serviceGetProfileList();
  }

  void serviceGetProfileList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.profile,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        profileList = ProfileModel.fromJson(response).list;
        getProfileMainData();
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void serviceSubmitProfileImage() {
    context.loaderOverlay.show();

    Map<String, dynamic> param = {};

    ApiManager.sharedInstance.postRequestWithMedia(
      param: param,
      selectedImage: galleryImage!,
      url: Api.profileImage,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        showErrorAlertWithOkCallback(context, App().appName,
            "Profile Image Successfully uploaded", () {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void getProfileMainData() {
    for (var element in profileList) {
      if (element.key == "Name") {
        username = element.value;
      } else if (element.key == "Account Number") {
        accountNumber = element.value;
      } else if (element.key == "profie_pic") {
        profilepicURL = element.value;
      }
    }

    setState(() {});
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => galleryImage = imageTemp);
      serviceSubmitProfileImage();
    } on PlatformException catch (e) {
      // ignore: use_build_context_synchronously
      showErrorAlert(context, App().appName, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (widget.backCallback != null) {
          widget.backCallback?.call();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              widget.backCallback?.call();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 214, 214, 214),
                        radius: 50,
                        foregroundImage: galleryImage != null
                            ? Image.file(galleryImage!).image
                            : NetworkImage(Uri.parse(profilepicURL).toString()),
                      ),
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: CircleAvatar(
                            backgroundColor:
                                AppColors.themeColor.withOpacity(.8),
                            radius: 20,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "A/C No. $accountNumber",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileList.length,
                  itemBuilder: (context, index) {
                    var detail = profileList[index];

                    return detail.key == "Phone"
                        ? GestureDetector(
                            onTap: () {},
                            child: CardWidget(
                              title: detail.key,
                              value: detail.value,
                            ),
                          )
                        : detail.key == "email"
                            ? GestureDetector(
                                onTap: () {},
                                child: CardWidget(
                                  title: detail.key,
                                  value: detail.value,
                                ),
                              )
                            : detail.key == "Aadhar"
                                ? GestureDetector(
                                    onTap: () {},
                                    child: CardWidget(
                                      title: detail.key,
                                      value: detail.value,
                                    ),
                                  )
                                : detail.key == "Pan"
                                    ? GestureDetector(
                                        onTap: () {},
                                        child: CardWidget(
                                          title: detail.key,
                                          value: detail.value,
                                        ),
                                      )
                                    : const SizedBox(height: 0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String title;
  final String value;

  const CardWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          title == "Phone" ? "Phone number" : title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(
                  title == "Phone" ? Icons.phone : Icons.email,
                  color: AppColors.themeColor,
                ),
                const SizedBox(width: 15),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
