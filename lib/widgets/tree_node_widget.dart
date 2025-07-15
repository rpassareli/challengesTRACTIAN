import 'package:flutter/material.dart';
import '../../../models/node_item_model.dart';
import '../../../models/tree_node_model.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNodeModel<NodeItemModel> node;
  final int level;

  const TreeNodeWidget({super.key, required this.node, this.level = 0});

  @override
  State<TreeNodeWidget> createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.level <= 1;
  }

  @override
  Widget build(BuildContext context) {
    final node = widget.node;
    final item = node.data;
    final isExpandable = node.children.isNotEmpty;

    final bool hasAlert = _nodeHasAlert(node);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap:
              isExpandable
                  ? () => setState(() => _expanded = !_expanded)
                  : null,
          child: Padding(
            padding: EdgeInsets.only(
              left: widget.level * 16.0,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              children: [
                if (isExpandable)
                  Icon(
                    _expanded ? Icons.expand_more : Icons.chevron_right,
                    size: 18,
                  )
                else
                  const SizedBox(width: 18),
                const SizedBox(width: 4),
                _getIcon(item.type),
                const SizedBox(width: 6),
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Tooltip(
                          message: item.name,
                          child: Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: item.status == 'alert' ? Colors.red : null,
                              fontWeight:
                                  item.type == NodeType.component
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (hasAlert)
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.circle,
                            color: Colors.red,
                            size: 12,
                          ),
                        ),
                    ],
                  ),
                ),

                if (item.sensorType != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (item.sensorType == 'energy')
                          const Icon(Icons.bolt, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '[${item.sensorType}]',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),

        // 🔽 Exibe filhos somente se estiver expandido
        if (_expanded)
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: node.children.length,
            itemBuilder: (_, i) {
              return TreeNodeWidget(
                node: node.children[i],
                level: widget.level + 1,
              );
            },
          ),
      ],
    );
  }

  /// Ícone por tipo de item
  Widget _getIcon(NodeType type) {
    switch (type) {
      case NodeType.location:
        return Image.asset(
          'challengesTRACTIAN/assets/location.png',
          height: 18,
        );
      case NodeType.asset:
        return Image.asset('challengesTRACTIAN/assets/asset.png', height: 18);
      case NodeType.component:
        return Image.asset(
          'challengesTRACTIAN/assets/component.png',
          height: 18,
        );
    }
  }

  /// Recursivamente verifica se o nó atual ou qualquer filho está com status == 'alert'
  bool _nodeHasAlert(TreeNodeModel<NodeItemModel> node) {
    if (node.data.status == 'alert') return true;
    for (final child in node.children) {
      if (_nodeHasAlert(child)) return true;
    }
    return false;
  }
}
