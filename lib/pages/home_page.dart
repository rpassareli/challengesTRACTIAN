import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'asset_tree_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  List<Map<String, dynamic>> companies = [];
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  Future<void> _loadCompanies() async {
    try {
      companies = await ApiService().getCompanies();
      companies.sort((a, b) => a['name'].compareTo(b['name']));
    } catch (e) {
      debugPrint('Erro ao carregar empresas: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  void _sortCompanies(bool ascending) {
    setState(() {
      if (ascending) {
        companies.sort((a, b) => a['name'].compareTo(b['name']));
        _isAscending = true;
      } else {
        companies.sort((a, b) => b['name'].compareTo(a['name']));
        _isAscending = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        elevation: 2,
        centerTitle: true,
        title: Image.asset(
          'challengesTRACTIAN/assets/tractian_name.png',
          height: 28,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF17192D),
        foregroundColor: Colors.white,
        child: const Icon(Icons.sort_by_alpha),
        onPressed: () => _sortCompanies(!_isAscending),
      ),

      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : companies.isEmpty
              ? const Center(child: Text('Nenhuma empresa encontrada.'))
              : ListView.builder(
                itemCount: companies.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.business),
                      title: Text(
                        company['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => AssetTreePage(
                                  companyId: company['id'],
                                  companyName: company['name'],
                                ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
