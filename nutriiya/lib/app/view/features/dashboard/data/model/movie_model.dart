import '../../domain/entity/movie_entity.dart';

import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieResponseModel extends HiveObject {
  @HiveField(0)
  List<Search> search;

  @HiveField(1)
  String totalResults;

  @HiveField(2)
  String response;

  MovieResponseModel({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      search: (json["Search"] as List)
          .map((e) => Search.fromJson(e))
          .toList(),
      totalResults: json["totalResults"] ?? "",
      response: json["Response"] ?? "",
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      search: search,
      totalResults: totalResults,
      response: response,
    );
  }
}

@HiveType(typeId: 1)
class Search extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String year;

  @HiveField(2)
  String imdbID;

  @HiveField(3)
  String poster;

  Search({
    required this.title,
    required this.year,
    required this.imdbID,
    required this.poster,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      title: json["Title"] ?? "",
      year: json["Year"] ?? "",
      imdbID: json["imdbID"] ?? "",
      poster: json["Poster"] ?? "",
    );
  }
}