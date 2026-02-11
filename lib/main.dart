import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/controllers/user_controller.dart';
import 'package:github_user_kobintiles_app/views/favorite_list_view.dart';
import 'package:github_user_kobintiles_app/views/user_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Github Users',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("GitHub Users"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "List Users", icon: Icon(Icons.people)),
              Tab(text: "Favorite Users", icon: Icon(Icons.favorite)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserListView(controller: controller),
            FavoriteListView(controller: controller),
          ],
        ),
      ),
    );
  }
}
