import '../../domain/entity/movie_entity.dart';

import 'package:hive/hive.dart';

part 'movie_model.g.dart';


class MovieResponseModel {

  List<Search> search;
  String totalResults;

  String response;

  MovieResponseModel({
    required this.search,
    required this.totalResults,
    required this.response,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      search:json["Search"] != null ? List<Search>.from(json["Search"]
          .map((e) => Search.fromJson(e))) : [],
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


class Search {

  String title;


  String year;


  String imdbID;


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