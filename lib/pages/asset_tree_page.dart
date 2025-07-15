import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // <- compute()
import 'package:provider/provider.dart';
import '../provider/asset_tree_provider.dart';
import '../service/api_service.dart';
import '../utils/tree_builder.dart';
import '../widgets/filter_bar.dart';
import '../widgets/tree_node_widget.dart';


class AssetTreePage extends StatefulWidget {
  final String companyId;
  final String companyName;

  const AssetTreePage({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  State<AssetTreePage> createState() => _AssetTreePageState();
}

class _AssetTreePageState extends State<AssetTreePage> {
  bool _isLoading = true;
  late AssetTreeProvider _assetTreeProvider;

  @override
  void initState() {
    super.initState();
    _assetTreeProvider = Provider.of<AssetTreeProvider>(context, listen: false);
    Future.microtask(() => _fetchDataAndBuildTree());
  }

  Future<void> _fetchDataAndBuildTree() async {
    final api = ApiService();

    final rawAssets = await api.getRawAssets(widget.companyId);
    final rawLocations = await api.getRawLocations(widget.companyId);

    final payload = TreeBuilderPayload(
      assets: rawAssets,
      locations: rawLocations,
    );

    final tree = await compute(buildTreeInBackground, payload);

    _assetTreeProvider.setTree(tree);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assets - ${widget.companyName}')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          const FilterBar(),
          const Divider(),
          Expanded(
            child: Consumer<AssetTreeProvider>(
              builder: (context, provider, _) => ListView.builder(
                itemCount: provider.filteredTree.length,
                itemBuilder: (context, index) {
                  return TreeNodeWidget(
                    node: provider.filteredTree[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
