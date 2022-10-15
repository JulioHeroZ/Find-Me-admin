// ignore_for_file: prefer_const_constructors

import 'package:find_me_admin/screens/category_screen.dart';
import 'package:find_me_admin/screens/dashboard_screen.dart';
import 'package:find_me_admin/screens/main_category_screen.dart';
import 'package:find_me_admin/screens/sub_category_screen.dart';
import 'package:find_me_admin/screens/vendors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCOnhUZm4EXzNxOd5sbjjf0BmyU2fyUzlw",
          authDomain: "find-me-cf925.firebaseapp.com",
          databaseURL: "https://find-me-cf925-default-rtdb.firebaseio.com",
          projectId: "find-me-cf925",
          storageBucket: "find-me-cf925.appspot.com",
          messagingSenderId: "158170322281",
          appId: "1:158170322281:web:79227764dd8f75dcdb99f8",
          measurementId: "G-94TLQF3HCZ"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Find Me Web Admin',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: SideMenu(),
      builder: EasyLoading.init(),
    );
  }
}

class SideMenu extends StatefulWidget {
  static const String id = 'side_menu';
  const SideMenu({Key? key}) : super(key: key);
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Widget _selectedScreen = DashBoardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashBoardScreen.id:
        setState(() {
          _selectedScreen = const DashBoardScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;
      case MainCategoryScreen.id:
        setState(() {
          _selectedScreen = const MainCategoryScreen();
        });
        break;
      case SubCategoryScreen.id:
        setState(() {
          _selectedScreen = const SubCategoryScreen();
        });
        break;
      case VendorScreen.id:
        setState(() {
          _selectedScreen = const VendorScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            route: DashBoardScreen.id,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Categorias',
            icon: IconlyLight.category,
            children: [
              AdminMenuItem(
                title: 'Categoria',
                route: CategoryScreen.id,
              ),
              AdminMenuItem(
                title: 'Categoria Principal',
                route: MainCategoryScreen.id,
              ),
              AdminMenuItem(
                title: 'Sub Categoria',
                route: SubCategoryScreen.id,
              ),
            ],
          ),
          AdminMenuItem(
            title: 'Vendedores',
            route: VendorScreen.id,
            icon: Icons.group,
          ),
        ],
        selectedRoute: SideMenu.id,
        onSelected: (item) {
          screenSelector(item);
          // if (item.route != null) {
          //   Navigator.of(context).pushNamed(item.route!);
          // }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Find Me',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: _selectedScreen,
      ),
    );
  }
}
