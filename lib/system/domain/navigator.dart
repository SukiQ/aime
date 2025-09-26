class NavigatorResult {
  final NavigatorOperation operation;
  final dynamic result;

  NavigatorResult({this.operation = NavigatorOperation.none, this.result});
}

enum NavigatorOperation { none, add, remove, update }
