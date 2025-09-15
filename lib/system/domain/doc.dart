abstract class Doc {
  String? id;

  Doc();

  Doc.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
