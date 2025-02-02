import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.photo});
  final String photo;

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          width: isPage.width, 
          height: isPage.height,
          child: CachedNetworkImage(
            imageUrl: photo,
            fit: BoxFit.fitWidth,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned(
          bottom: 60,
          left: 30,
          right: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        applyImg(context, isPage);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.primary,
                        size: 33,
                      )),
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        // saveImage(context);
                      },
                      icon: Icon(
                        Icons.save_alt,
                        color: Theme.of(context).colorScheme.primary,
                        size: 33,
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
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
