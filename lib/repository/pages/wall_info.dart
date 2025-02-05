import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/domain/models/wallpaper_model/wall_data_model.dart';

import '../../data/bloc/wall_bloc/wall_state.dart';
import '../../data/bloc/wall_bloc/wallpaper_bloc.dart';

class WallpaperInfoPage extends StatelessWidget {
  const WallpaperInfoPage({super.key, required this.photoModel});

  final PhotoModel photoModel;

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo info"),
      ),
      body: BlocBuilder<WallpaperBloc, WallpaperStates>(
        builder: (context, state) {
          if (state is WallpaperLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (state is WallpaperErrorState) {
            log(state.errorMsg);
            return Center(child: Text(state.errorMsg));
          }

          if (state is WallpaperLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: isPage.width,
                  height: isPage.height * 0.4,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    imageUrl: photoModel.src!.landscape!,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                // SizedBox(
                //   height:100,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       itemCount: 8,
                //       itemBuilder: (context, index) {
                //       var eachImg =  state.mData.photos![index];
                //         return SizedBox(
                //           width: isPage.width,
                //           height: isPage.height,
                //           child: CachedNetworkImage(
                //             imageUrl: eachImg.src,
                //             fit: BoxFit.fitWidth,
                //             errorWidget: (context, url, error) => const Icon(Icons.error),
                //           ),
                //         );
                //       },),
                // ),
                SizedBox(
                  height: isPage.height * 0.021,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Photographer Details",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(
                        height: isPage.height * 0.045,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Text("Id : ",  style: Theme.of(context).textTheme.titleLarge,),
                              title: Text(photoModel.id.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                              ),
                              trailing: photoModel.liked! ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                            ), ListTile(
                              leading:  Text("Photographer Id : ",  style: Theme.of(context).textTheme.titleLarge,),
                              title: Text(photoModel.photographer_id!.toString()),
                            ),ListTile(
                              leading:  Text("Photographer : ",  style: Theme.of(context).textTheme.titleLarge,),
                              title: Text(photoModel.photographer!.toString()),
                            ),ListTile(
                              leading:  Text("Dimension : ",  style: Theme.of(context).textTheme.titleLarge,),
                              title: Text("${photoModel.width} * ${photoModel.height}",  style: Theme.of(context).textTheme.titleLarge,),
                            ),
                          ],
                        );
                      },),
                    ],
                  ),
                ))
              ],
            );
          }

          return Container(
              // color: Colors.red,
              // width: 100,
              // height: 100,
              );
        },
      ),
    );
  }
}
