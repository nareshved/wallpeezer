import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_events.dart';
import 'package:wallpeezer/data/bloc/wall_bloc/wall_state.dart';
import 'package:wallpeezer/data/remote/api/api_urls.dart';
import 'package:wallpeezer/domain/models/featured_categories/featured_cat.dart';
import 'package:wallpeezer/domain/models/wallpaper_model/wall_data_model.dart';

import '../../remote/api/api_helper.dart';
import '../../remote/api/app_exception.dart';

class WallpaperBloc extends Bloc<WallpaperEvents, WallpaperStates>{
  ApiHelper apiHelper;
  WallpaperBloc({required this.apiHelper}) : super (WallpaperInitialState()){

    on<GetTrendingWallpaperEvent>((event, emit) async{
      emit(WallpaperLoadingState());

      try{
        // get response body successfully
        var rawData = await apiHelper.getApi(ApiUrls.trendingWallpaper);
        var wallpaperDataModel = WallpaperDataModel.fromJson(rawData);
        // save to loaded State mData
        emit(WallpaperLoadedState(mData: wallpaperDataModel));
        //
      }
          catch(e) {
            emit(WallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
          }
    },
    );
    on<GetSearchWallpaperEvent>((event, emit) async {

      emit(WallpaperLoadingState());

      try {
    //    var rawData = await apiHelper.getApi("${ApiUrls.searchWallpaper}?query=car");
        var rawData = await apiHelper.getApi("${ApiUrls.searchWallpaper}?query=${event.query}&per_page=30&color=${event.colorCodeStr}");
        var wallpaperDataModel = WallpaperDataModel.fromJson(rawData);
        // save to loaded State mData
        emit(WallpaperLoadedState(mData: wallpaperDataModel));
      }
      catch(e) {
        emit(WallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
      }
    },);

    on<GetFeaturedCollectionsEvent>((event, emit) async {
      emit(WallpaperLoadingState());

      try{
     var rawData =  await apiHelper.getApi(ApiUrls.featuredCollections);
     var categoryModel = FeaturedCollectionModel.fromJson(rawData);

      emit(CategoryLoadedState(featuredCollectionModel: categoryModel));

      } catch (e) {
        emit(WallpaperErrorState(errorMsg:(e as AppException).toErrorMsg()));
      }
    },);
  }
}