import '../models/asset_model.dart';
import '../models/location_model.dart';
import '../models/node_item_model.dart';
import '../models/tree_node_model.dart';

/// Payload usado pelo `compute()` para carregar os dados fora da main thread
class TreeBuilderPayload {
  final List<Map<String, dynamic>> assets;
  final List<Map<String, dynamic>> locations;

  TreeBuilderPayload({
    required this.assets,
    required this.locations,
  });
}

/// Função que roda no isolado e constrói a árvore
List<TreeNodeModel<NodeItemModel>> buildTreeInBackground(TreeBuilderPayload payload) {
  final assets = payload.assets.map((e) => AssetModel.fromJson(e)).toList();
  final locations = payload.locations.map((e) => LocationModel.fromJson(e)).toList();

  return buildAssetTree(locations, assets);
}

/// Função original — não precisa ser modificada
List<TreeNodeModel<NodeItemModel>> buildAssetTree(
    List<LocationModel> locations,
    List<AssetModel> assets,
    ) {
  final Map<String, TreeNodeModel<NodeItemModel>> locationNodes = {};
  final Map<String, TreeNodeModel<NodeItemModel>> assetNodes = {};

  for (final loc in locations) {
    locationNodes[loc.id] = TreeNodeModel(
      data: NodeItemModel(
        id: loc.id,
        name: loc.name,
        type: NodeType.location,
        parentId: loc.parentId,
      ),
      children: [],
    );
  }

  for (final asset in assets) {
    final type = asset.sensorType != null ? NodeType.component : NodeType.asset;
    assetNodes[asset.id] = TreeNodeModel(
      data: NodeItemModel(
        id: asset.id,
        name: asset.name,
        type: type,
        parentId: asset.parentId,
        locationId: asset.locationId,
        sensorType: asset.sensorType,
        status: asset.status,
      ),
      children: [],
    );
  }

  for (final asset in assetNodes.values) {
    if (asset.data.parentId != null && assetNodes.containsKey(asset.data.parentId)) {
      assetNodes[asset.data.parentId!]!.children.add(asset);
    } else if (asset.data.locationId != null && locationNodes.containsKey(asset.data.locationId)) {
      locationNodes[asset.data.locationId!]!.children.add(asset);
    }
  }

  for (final loc in locationNodes.values) {
    if (loc.data.parentId != null && locationNodes.containsKey(loc.data.parentId)) {
      locationNodes[loc.data.parentId!]!.children.add(loc);
    }
  }

  final List<TreeNodeModel<NodeItemModel>> rootNodes = [];

  for (final loc in locationNodes.values) {
    if (loc.data.parentId == null) {
      rootNodes.add(loc);
    }
  }

  for (final asset in assetNodes.values) {
    if (asset.data.parentId == null && asset.data.locationId == null) {
      rootNodes.add(asset);
    }
  }

  return rootNodes;
}
