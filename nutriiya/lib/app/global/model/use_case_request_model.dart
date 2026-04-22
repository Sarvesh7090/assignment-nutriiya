class UseCaseRequestModel<Type> {
  Map<String, String>? query;
  Type? body;
  Map<String, dynamic>? requestBody;
  String endPoint;

  UseCaseRequestModel(
      {this.query = const {}, this.body, this.requestBody = const {},this.endPoint=''});
}
