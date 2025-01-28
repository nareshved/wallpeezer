import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wallpeezer/data/remote/api/api_urls.dart';
import 'package:wallpeezer/domain/models/wallpaper_model/wall_data_model.dart';

// api func
class ApiHelper {
  WallpaperDataModel? mData;
  Future<void> getApi(String url, {Map<String, String>? header}) async {
    var uri = Uri.parse(url);

    try {
      var response = await http.get(uri,
          headers: header ?? {"Authorization": ApiUrls.adminApiKey});

      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        mData = WallpaperDataModel.fromJson(resData);
      }
    } catch (e) {
      log("get api not and get error in api_helper : ${e.toString()}");
    }
  }

  // Future<void> getApi(String url, {Map<String, String>? header}) async {
  //   var uri = Uri.parse(url);

  //   try {
  //     http.get(uri, headers: header ?? {"Authorization": ApiUrls.adminApiKey});

  //   } catch (e) {
  //     log("get api not and get error in api_helper : ${e.toString()}");
  //   }
  // }
}
