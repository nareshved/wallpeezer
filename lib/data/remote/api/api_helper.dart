import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:wallpeezer/data/remote/api/api_urls.dart';
import 'package:wallpeezer/domain/models/wallpaper_model/wall_data_model.dart';

// api func
class ApiHelper {

  Future<dynamic> getApi(String url, {Map<String, String>? header}) async {
    var uri = Uri.parse(url);

    try {
      var response = await http.get(uri,
          headers: header ?? {"Authorization": ApiUrls.adminApiKey});

      // internet proper but other error handle

      return returnDataResponse(response);
    }
    on SocketException {
     throw FetchDataException(body: "Internet Error not Connected");
    }
  }

  dynamic returnDataResponse (http.Response res) {

     switch (res.statusCode) {

       case 200:
         var actRes = res.body;
         var mData = jsonDecode(actRes);
         return mData;

       case 400:
         throw BadRequestException(body: res.body.toString());

       case 401:
       case 403:
         throw UnAuthorizedException(body: res.body.toString());

       case 500:
         default:
         throw InvalidRequest(body: res.body.toString());

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
}
