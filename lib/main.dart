import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'provider/asset_tree_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssetTreeProvider(),
      child: MaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          scrollbars: true,
          dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
        ),

        title: 'Tractian Challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF17192D),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF17192D),
            foregroundColor: Colors.white,
            elevation: 2,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.white,
            textColor: Colors.white,
            tileColor: Color.fromRGBO(33, 136, 255, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
