abstract class WallpaperEvents {}


class GetTrendingWallpaperEvent extends WallpaperEvents{}

class GetSearchWallpaperEvent extends WallpaperEvents{
  String query;

  GetSearchWallpaperEvent({required this.query});
}

