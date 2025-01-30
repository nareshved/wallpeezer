import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_state.dart';
import 'package:wallpeezer/domain/app_constants/app_info.dart';
import 'package:wallpeezer/repository/pages/details_page.dart';
import 'package:wallpeezer/repository/pages/login_page.dart';

import '../../data/bloc/wall_bloc/wallpaper_bloc.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //
    BlocProvider.of<WallpaperBloc>(context)
        .add(GetSearchWallpaperEvent(query: "red car"));
    //
    // BlocProvider.of<WallpaperBloc>(context)
    //     .add(GetTrendingWallpaperEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: 150,
                color: Colors.red,
              ),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<RegisterUserBloc>(context)
                        .add(LogOutUserEvent());

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  icon: const Icon(Icons.login_outlined)),
              title: const Text("LogOut"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(AppInfo.appName),
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
              children: [
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: CustomSearchBar(
                    searchController: searchController,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  ),
                ),
              ],
            );
          }

          return Container(
            color: Colors.red,
            width: 100,
            height: 100,
          );
        },
      ),
    );
  }
}
