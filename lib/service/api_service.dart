import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final _baseUrl = 'https://fake-api.tractian.com';

  Future<List<Map<String, dynamic>>> getCompanies() async {
    final res = await http.get(Uri.parse('$_baseUrl/companies'));
    return List<Map<String, dynamic>>.from(json.decode(res.body));
  }

  // ✅ Novo método: retorna dados crus, ideal para usar com compute()
  Future<List<Map<String, dynamic>>> getRawAssets(String companyId) async {
    final res = await http.get(Uri.parse('$_baseUrl/companies/$companyId/assets'));
    return List<Map<String, dynamic>>.from(json.decode(res.body));
  }

  // ✅ Novo método: retorna dados crus, ideal para usar com compute()
  Future<List<Map<String, dynamic>>> getRawLocations(String companyId) async {
    final res = await http.get(Uri.parse('$_baseUrl/companies/$companyId/locations'));
    return List<Map<String, dynamic>>.from(json.decode(res.body));
  }

// 👇 Estes podem continuar existindo caso queira usá-los fora do compute()
/*
  Future<List<AssetModel>> getAssets(String companyId) async {
    final res = await http.get(Uri.parse('$_baseUrl/companies/$companyId/assets'));
    final list = json.decode(res.body) as List;
    return list.map((e) => AssetModel.fromJson(e)).toList();
  }

  Future<List<LocationModel>> getLocations(String companyId) async {
    final res = await http.get(Uri.parse('$_baseUrl/companies/$companyId/locations'));
    final list = json.decode(res.body) as List;
    return list.map((e) => LocationModel.fromJson(e)).toList();
  }
  */
}
