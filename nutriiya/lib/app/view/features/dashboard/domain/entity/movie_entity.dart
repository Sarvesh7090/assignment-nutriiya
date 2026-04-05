import '../../data/model/movie_model.dart';

class MovieEntity {
  List<Search> search;
  String totalResults;
  String response;


  MovieEntity({
    required this.response,
    required this.search,
    required this.totalResults
  });
}