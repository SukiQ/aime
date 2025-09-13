abstract class Doc {
  late String id;

  Doc();

  Doc.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
