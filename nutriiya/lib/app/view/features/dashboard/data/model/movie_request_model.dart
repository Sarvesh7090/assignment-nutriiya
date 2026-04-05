class MovieRequestModel {
  final int page;
  final String? query;

  const MovieRequestModel({
    required this.page,
    this.query,
  });
}