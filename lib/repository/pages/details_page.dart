import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpeezer/domain/models/wallpaper_model/wall_data_model.dart';
import 'package:wallpeezer/repository/pages/wall_info.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.photo, this.photoModel});
  final String photo;
  final PhotoModel? photoModel;

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("info",),foregroundColor: Colors.white,
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) =>
         WallpaperInfoPage(photoModel: photoModel!,),));
        },
       icon: const Icon(Icons.info_outline, ),
        // const Icon(Icons.add_photo_alternate_outlined, color: Colors.white,),
        ),
        body: SizedBox(
          width: isPage.width,
          height: isPage.height,
          child: CachedNetworkImage(
            imageUrl: photo,
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }

  void applyImg(BuildContext context, Size isPage) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Where to Set Wallpaper"),
          actions: [
            TextButton(
                onPressed: () {
                  var imgStream = Wallpaper.imageDownloadProgress(photo);

                  imgStream.listen((event) {
                    log(event);
                  }, onDone: () async {
                    var check = await Wallpaper.homeScreen(
                        width: isPage.width,
                        height: isPage.height,
                        options: RequestSizeOptions.resizeFit)
                        .then(
                          (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Wallpaper Apply Home Screen")));
                      },
                    );

                    log(check);
                  }, onError: (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("$e")));
                  });
                },
                child: const Text("Home Screen")),
            TextButton(
                onPressed: () {
                  var imgStream = Wallpaper.imageDownloadProgress(photo);

                  imgStream.listen((event) {
                    log(event);
                  }, onDone: () async {
                    var check = await Wallpaper.lockScreen(
                        width: isPage.width,
                        height: isPage.height,
                        options: RequestSizeOptions.resizeFit)
                        .then(
                          (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Wallpaper Apply Lock Screen")));
                      },
                    );
                    log(check);
                  }, onError: (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("$e")));
                  });
                },
                child: const Text("Lock Screen")),
            TextButton(
                onPressed: () {
                  var imgStream = Wallpaper.imageDownloadProgress(photo);

                  imgStream.listen((event) {
                    log(event);
                  }, onDone: () async {
                    var check = await Wallpaper.bothScreen(
                        width: isPage.width,
                        height: isPage.height,
                        options: RequestSizeOptions.resizeFit)
                        .then(
                          (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Wallpaper Apply Both Screen")));
                      },
                    );
                    log(check);
                  }, onError: (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("$e")));
                  });
                },
                child: const Text("Both Screen")),
          ],
        );
      },
    );
  }

//  void saveImage(BuildContext context){
//   GallerySaver.saveImage(photo).then((value) {

//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wallpaper Saved Success")));
//   },);
//  }
}