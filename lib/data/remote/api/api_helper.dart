import 'dart:convert';
import 'dart:io';

import 'api_urls.dart';
import 'app_exception.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<dynamic> getApi(String url, {Map<String, String>? header}) async {
    var uri = Uri.parse(url);

    try {
      var response = await http.get(uri,
          headers: header ?? {"Authorization": ApiUrls.adminApiKey});

      return returnDataResponse(response);
    } on SocketException {
      throw FetchDataException(body: "Internet Not Connected");
    }
  }

  dynamic returnDataResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        var actData = res.body;
        var mData = jsonDecode(actData);
        return mData;

      case 400:
        BadRequestException(body: res.body.toString());
      case 401:
      case 403:
        UnAuthorizedException(body: res.body.toString());

      case 500:
      default:
        FetchDataException(
            body: "error in server isssue with statusCode : ${res.statusCode}");
    }
  }
}






  // Future<void> getApi(String url, {Map<String, String>? header}) async {
  //   var uri = Uri.parse(url);
  //
  //   try {
  //     var response = await http.get(uri,
  //         headers: header ?? {"Authorization": ApiUrls.adminApiKey});
  //
  //     if (response.statusCode == 200) {
  //       var resData = jsonDecode(response.body);
  //       mData = WallpaperDataModel.fromJson(resData);
  //     }
  //   } catch (e) {
  //     log("get api not and get error in api_helper : ${e.toString()}");
  //   }
  // }

  // Future<void> getApi(String url, {Map<String, String>? header}) async {
  //   var uri = Uri.parse(url);

  //   try {
  //     http.get(uri, headers: header ?? {"Authorization": ApiUrls.adminApiKey});

  //   } catch (e) {
  //     log("get api not and get error in api_helper : ${e.toString()}");
  //   }
  // }
