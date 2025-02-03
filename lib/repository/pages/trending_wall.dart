import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_state.dart';

import '../../data/bloc/wall_bloc/wallpaper_bloc.dart';
import 'details_page.dart';

class TrendingWallpapers extends StatefulWidget {
  const TrendingWallpapers({super.key});

  @override
  State<TrendingWallpapers> createState() => _TrendingWallpapersState();
}

class _TrendingWallpapersState extends State<TrendingWallpapers> {

  @override
  void initState() {
    super.initState();
    //
    // BlocProvider.of<WallpaperBloc>(context)
    //     .add(GetSearchWallpaperEvent(query: "car"));
    //
    BlocProvider.of<WallpaperBloc>(context)
        .add(GetTrendingWallpaperEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending Wallpaper"),
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: state.mData.photos!.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 9 / 16,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var eachPhoto =
                      state.mData.photos![index].src!.portrait;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsPage(photo: eachPhoto),
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: CachedNetworkImage(
                        imageUrl: eachPhoto!,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
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
