class FeaturedCollectionModel {
  String? next_page;
  num? page, per_page, total_results;
  List<CollectionModel>? collections;

  FeaturedCollectionModel({
   required this.collections,
   required this.page,
   required this.per_page,
   required this.total_results,
   required this.next_page,
});

  factory FeaturedCollectionModel.fromJson(Map<String, dynamic> json){
   
   List<CollectionModel> allCollectionsData = [];
   
   for(Map<String, dynamic> eachCollection in json["collections"]){
    allCollectionsData.add(CollectionModel.fromJson(eachCollection));
   }
   
   return FeaturedCollectionModel(
       page: json["page"],
       per_page: json["per_page"],
       total_results: json["total_results"],
       next_page: json["next_page"],
    collections: allCollectionsData,
   );
  }

}

class CollectionModel {
  String? description, id, title;
  num? media_count, photos_count, videos_count;
  bool? private;

  CollectionModel(
      {required this.description,
      required this.id,
      required this.media_count,
      required this.photos_count,
      required this.private,
      required this.title,
      required this.videos_count});

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
        description: json["description"],
        id: json["id"],
        media_count: json["media_count"],
        photos_count: json["photos_count"],
        private: json["private"],
        title: json["title"],
        videos_count: json["videos_count"]);
  }
}
