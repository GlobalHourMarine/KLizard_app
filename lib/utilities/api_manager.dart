import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:klizards/main.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiManager {
  static ApiManager sharedInstance = ApiManager();

  void postRequest({
    required Map<String, String> param,
    required String url,
    Function()? completionCallback,
    Function(dynamic responseBody)? successCallback,
    Function(String error)? failureCallback,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      completionCallback!();
      failureCallback!(
          "Internet is not connected. Please check your internet connection.");
      return;
    }
    try {
      final value = prefs.getString("access_token") ?? "";
      final Map<String, String> headers = {
        'Authorization': value,
      };
      // ignore: avoid_print
      print(value);
      final response =
          await http.post(Uri.parse(url), body: param, headers: headers);

      completionCallback!();
      var body = jsonDecode(response.body);

      if (body['status'] == true) {
        successCallback!(body);
      } else {
        failureCallback!(body["message"]);
      }
    } catch (e) {
      completionCallback!();

      failureCallback!("Something went wrong");
      rethrow; // You can choose to rethrow the exception or handle it accordingly.
    }
  }

  void postRequestWithMedia({
    required Map<String, dynamic> param,
    required File selectedImage,
    required String url,
    Function()? completionCallback,
    Function(dynamic responseBody)? successCallback,
    Function(String error)? failureCallback,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      completionCallback!();
      failureCallback!(
          "Internet is not connected. Please check your internet connection.");
      return;
    }
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      var imageField = http.MultipartFile.fromBytes(
          'media', selectedImage.readAsBytesSync(),
          filename: selectedImage.path.split("/").last);
      request.files.add(imageField);
      final value = prefs.getString("access_token") ?? "";

      request.headers['Authorization'] = value;
      param.forEach((key, value) {
        request.fields[key] = value;
      });

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      completionCallback!();

      var body = jsonDecode(responseBody.body);
      if (body['status'] == true) {
        successCallback!(body);
      } else {
        failureCallback!(body["message"]);
      }
    } catch (e) {
      completionCallback!();
      failureCallback!("Something went wrong");
      rethrow; // You can choose to rethrow the exception or handle it accordingly.
    }
  }

  void getRequest({
    Map<String, String>? param,
    required String url,
    required Function()? completionCallback,
    required Function(dynamic responseBody)? successCallback,
    required Function(String error)? failureCallback,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      completionCallback!();
      failureCallback!(
          "Internet is not connected. Please check your internet connection.");
      return;
    }

    try {
      final Uri uri = Uri.parse(url).replace(queryParameters: param);

      final value = prefs.getString("access_token") ?? "";
      final Map<String, String> headers = {
        'Authorization': value,
      };
      //print(value);

      final response = await http.get(uri, headers: headers);

      completionCallback!();
      var body = jsonDecode(response.body);

      if (body['status'] == true) {
        successCallback!(body);
      } else {
        failureCallback!(body["message"]);
      }
    } catch (e) {
      completionCallback!();
      failureCallback!("Something went wrong");
      rethrow; // You can choose to rethrow the exception or handle it accordingly.
    }
  }
}
