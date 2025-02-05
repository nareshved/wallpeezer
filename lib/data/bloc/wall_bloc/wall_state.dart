import 'package:wallpeezer/domain/models/featured_categories/featured_cat.dart';
import 'package:wallpeezer/domain/models/wallpaper_model/wall_data_model.dart';

abstract class WallpaperStates {}


class WallpaperInitialState extends WallpaperStates {}

class WallpaperLoadingState extends WallpaperStates {}

class WallpaperLoadedState extends WallpaperStates {
  WallpaperDataModel mData;
  WallpaperLoadedState({required this.mData});
}

class WallpaperErrorState extends WallpaperStates {

  String errorMsg;

  WallpaperErrorState({required this.errorMsg});
}

// loaded state for categoryModel

class CategoryLoadedState extends WallpaperStates {
  FeaturedCollectionModel featuredCollectionModel;

  CategoryLoadedState({required this.featuredCollectionModel});
}