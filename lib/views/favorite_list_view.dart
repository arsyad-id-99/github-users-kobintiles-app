import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/controllers/user_controller.dart';
import 'package:github_user_kobintiles_app/views/widgets/user_card.dart';

class FavoriteListView extends StatelessWidget {
  final UserController controller;
  const FavoriteListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.loadFavorites(),
      child: Obx(() {
        if (controller.favoriteList.isEmpty) {
          return const Center(child: Text("Belum ada user favorit"));
        }
        return ListView.builder(
          itemCount: controller.favoriteList.length,
          itemBuilder: (context, index) {
            final user = controller.favoriteList[index];
            return UserCard(
              user: user,
              isFromApi: false, // No need to fetch, data complete in DB
            );
          },
        );
      }),
    );
  }
}
