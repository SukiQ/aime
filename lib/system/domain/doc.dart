abstract class Doc {
  String? id;

  Doc();

  Doc.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Doc && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
