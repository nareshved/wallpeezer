import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_bloc.dart';
import 'package:wallpeezer/data/bloc/user_register/register_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_state.dart';
import 'package:wallpeezer/domain/app_constants/app_info.dart';
import 'package:wallpeezer/domain/models/color_model/color_model.dart';
import 'package:wallpeezer/repository/pages/login_page.dart';

import '../../data/bloc/wall_bloc/wallpaper_bloc.dart';
import '../widgets/search_bar.dart';
import 'details_page.dart';

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
        .add(GetSearchWallpaperEvent(query: "car"));
    //
    // BlocProvider.of<WallpaperBloc>(context)
    //     .add(GetTrendingWallpaperEvent());
  }

  List<ColorModel> allColors = [
    ColorModel(colorValue: Colors.blue, colorCode: "0000ff"),
    ColorModel(colorValue: Colors.red, colorCode: "ff0000"),
    ColorModel(colorValue: Colors.green, colorCode: "00ff00"),
    ColorModel(colorValue: Colors.yellow, colorCode: "ffff00"),
    ColorModel(colorValue: Colors.orange, colorCode: "ffa500"),
    ColorModel(colorValue: Colors.purple, colorCode: "800080"),
    ColorModel(colorValue: Colors.pink, colorCode: "ffc0cb"),
    ColorModel(colorValue: Colors.brown, colorCode: "a52a2a"),
    ColorModel(colorValue: Colors.grey, colorCode: "808080"),
    ColorModel(colorValue: Colors.black, colorCode: "000000"),
  ];

  @override
  Widget build(BuildContext context) {
    final isPage = MediaQuery.sizeOf(context);
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
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
      ),
      appBar: AppBar(
        title: const Text(AppInfo.appName),
      ),
// bottomNavigationBar: const BottomNavbarPage(),
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
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: CustomSearchBar(
                    searchController: searchController,
                  ),
                ),
                 SizedBox(
                  height: isPage.height*0.011,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Search by Color", style: Theme.of(context).textTheme.bodyLarge,),
                ),
                SizedBox(
                  height: isPage.height*0.011,
                ),
                SizedBox(
                  height: 75,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: allColors.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          BlocProvider.of<WallpaperBloc>(context)
                              .add(GetSearchWallpaperEvent(colorCodeStr: allColors[index].colorCode, query: searchController.text.trim()));
                        },
                        child: Container(
                          width: 47, height: 47,
                          margin: const EdgeInsets.all(4),
                        decoration:  BoxDecoration(
                         shape: BoxShape.circle,
                          color: allColors[index].colorValue,
                        ),
                        ),
                      );
                  },),
                ),
                SizedBox(height: isPage.height*0.03,),
                Expanded(
                  child: Padding(
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
                                      DetailsPage(photo: eachPhoto, photoModel: state.mData.photos![index],),
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
            // color: Colors.red,
            // width: 100,
            // height: 100,
          );
        },
      ),
    );
  }
}
