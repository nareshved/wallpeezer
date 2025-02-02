abstract class WallpaperEvents {}


class GetTrendingWallpaperEvent extends WallpaperEvents{}

class GetSearchWallpaperEvent extends WallpaperEvents{
  String query;
  String? colorCodeStr;

  GetSearchWallpaperEvent({required this.query, this.colorCodeStr});
}

