import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_state.dart';

import '../../data/bloc/wall_bloc/wallpaper_bloc.dart';

class CategoriesWallpapers extends StatefulWidget {
  const CategoriesWallpapers({super.key});

  @override
  State<CategoriesWallpapers> createState() => _CategoriesWallpapersState();
}

class _CategoriesWallpapersState extends State<CategoriesWallpapers> {

  @override
  void initState() {
    super.initState();

    BlocProvider.of<WallpaperBloc>(context).add(GetFeaturedCollectionsEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Featured Collections"),
      ),
      body: BlocBuilder<WallpaperBloc, WallpaperStates>(
        builder: (context, state) {

          if(state is WallpaperLoadingState){
            return const Center(child: CircularProgressIndicator.adaptive(),);
          }
          if (state is WallpaperErrorState) {
            log(state.errorMsg);
            return Center(child: Text(state.errorMsg));
          }

          if(state is CategoryLoadedState){
           return ListView.builder(
             itemCount: state.featuredCollectionModel.collections!.length,
               itemBuilder: (context, index) {
               var mData = state.featuredCollectionModel.collections!;
               return Container(
                 margin: const EdgeInsets.all(9),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(11),
                   color: Colors.purple
                 ),
                 child: ListTile(
                   leading: CircleAvatar(backgroundColor: Colors.white,child: Text("$index"),),
                   title: Text(mData[index].title!),
                   subtitle: Text("${mData[index].photos_count.toString()} Wallpapers"),
                   
                 ),
               );
               },
           );
          }

          // lottie -- no data animation
          return Container();
      },),
    );
  }
}
