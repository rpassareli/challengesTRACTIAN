import 'package:flutter/material.dart';
import '../models/node_item_model.dart';
import '../models/tree_node_model.dart';

class AssetTreeProvider extends ChangeNotifier {
  List<TreeNodeModel<NodeItemModel>> fullTree = [];
  List<TreeNodeModel<NodeItemModel>> filteredTree = [];

  String searchText = '';
  bool filterEnergyOnly = false;
  bool filterCriticalOnly = false;

  // void setTree(List<TreeNodeModel<NodeItemModel>> tree) {
  //   fullTree = tree;
  //   applyFilters();
  // }
  void setTree(List<TreeNodeModel<NodeItemModel>> tree) {
    fullTree = tree;

    // RESETAR filtros ao carregar nova empresa
    searchText = '';
    filterEnergyOnly = false;
    filterCriticalOnly = false;

    applyFilters();
    notifyListeners(); // garante atualização visual
  }

  void updateFilters({String? text, bool? energyOnly, bool? criticalOnly}) {
    if (text != null) searchText = text.toLowerCase();
    if (energyOnly != null) filterEnergyOnly = energyOnly;
    if (criticalOnly != null) filterCriticalOnly = criticalOnly;
    applyFilters();
  }

  void applyFilters() {
    filteredTree = [];

    for (var node in fullTree) {
      final result = _filterNode(node);
      if (result != null) filteredTree.add(result);
    }

    notifyListeners();
  }

  TreeNodeModel<NodeItemModel>? _filterNode(TreeNodeModel<NodeItemModel> node) {
    bool matches = _matchesFilter(node.data);
    List<TreeNodeModel<NodeItemModel>> children = [];

    for (var child in node.children) {
      final filtered = _filterNode(child);
      if (filtered != null) children.add(filtered);
    }

    if (matches || children.isNotEmpty) {
      return TreeNodeModel(data: node.data, children: children);
    }

    return null;
  }

  bool _matchesFilter(NodeItemModel item) {
    if (searchText.isNotEmpty && !item.name.toLowerCase().contains(searchText)) return false;
    if (filterEnergyOnly && item.sensorType != 'energy') return false;
    if (filterCriticalOnly && item.status != 'alert') return false;
    return true;
  }
}
