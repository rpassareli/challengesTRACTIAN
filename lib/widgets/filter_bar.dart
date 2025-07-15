import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../provider/asset_tree_provider.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssetTreeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          // 🔍 Campo de busca
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  provider.updateFilters(text: '');
                  setState(() {}); // força rebuild do botão de limpar
                },
              )
                  : null,
              labelText: 'Buscar por nome',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              isDense: true,
            ),
            onChanged: (text) {
              provider.updateFilters(text: text);
              setState(() {}); // mostra ou esconde o botão de limpar
            },

          ),
          const SizedBox(height: 12),

          // ⚡ Toggles
          Wrap(
            spacing: 12,
            children: [
              FilterChip(
                label: const Text('⚡ Sensor de Energia'),
                selected: provider.filterEnergyOnly,
                onSelected: (value) {
                  provider.updateFilters(energyOnly: value);
                },
              ),
              FilterChip(
                label: const Text('🔴 Crítico'),
                selected: provider.filterCriticalOnly,
                onSelected: (value) {
                  provider.updateFilters(criticalOnly: value);
                },
              ),
            ],
          ),
          // TextButton.icon(
          //   onPressed: () {
          //     provider.updateFilters(
          //       text: '',
          //       energyOnly: false,
          //       criticalOnly: false,
          //     );
          //   },
          //   icon: const Icon(Icons.clear),
          //   label: const Text('Limpar filtros'),
          // ),

        ],
      ),
    );
  }
}
