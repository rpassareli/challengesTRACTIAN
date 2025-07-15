enum NodeType { location, asset, component }

class NodeItemModel {
  final String id;
  final String name;
  final NodeType type;
  final String? parentId;
  final String? locationId;
  final String? sensorType;
  final String? status;

  NodeItemModel({
    required this.id,
    required this.name,
    required this.type,
    this.parentId,
    this.locationId,
    this.sensorType,
    this.status,
  });
}
