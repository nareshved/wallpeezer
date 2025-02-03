import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpeezer/repository/pages/categories.dart';
import 'package:wallpeezer/repository/pages/homepage.dart';
import 'package:wallpeezer/repository/pages/settings.dart';
import 'package:wallpeezer/repository/pages/trending_wall.dart';
import 'package:wallpeezer/repository/pages/videos_page.dart';

class BottomNavbarPage extends StatefulWidget {
  const BottomNavbarPage({super.key});

  @override
  State<BottomNavbarPage> createState() => _BottomNavbarPageState();
}

class _BottomNavbarPageState extends State<BottomNavbarPage> {
  int mSelectedIndex = 0;
  List<Widget> navPages = const [
    HomePage(),
    TrendingWallpapers(),
    CategoriesWallpapers(),
    VideosWallpapers(),
    SettingsWallpapersPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
    unselectedItemColor: Colors.white,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    currentIndex: mSelectedIndex,
    onTap: (value) {
    setState(() {
    mSelectedIndex = value;
    });
    },

    items: const [
    BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.home), label: 'Home'),
    BottomNavigationBarItem(
    icon: Icon(Icons.trending_up_rounded), label: "Trending"),
    BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.circle_grid_3x3_fill),
    label: "Categories"),
    BottomNavigationBarItem(
    icon: Icon(CupertinoIcons.video_camera_solid),
    label: "Videos"),
    BottomNavigationBarItem(
    icon: Icon(Icons.settings), label: "Settings"),
    ]),
      body: navPages[mSelectedIndex],
    );
  }
}
