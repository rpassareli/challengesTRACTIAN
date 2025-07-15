class TreeNodeModel<T> {
  final T data;
  List<TreeNodeModel<T>> children;

  TreeNodeModel({
    required this.data,
    this.children = const [],
  });
}
