// file: user_card_widget.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/controllers/user_card_controller.dart';
import 'package:github_user_kobintiles_app/models/user_model.dart';
import 'package:github_user_kobintiles_app/views/user_detail_view.dart';

class UserCard extends StatelessWidget {
  final User user;
  final bool isFromApi;

  const UserCard({super.key, required this.user, required this.isFromApi});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      UserCardController(user),
      tag: user.id.toString(),
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
          backgroundColor: Colors.grey[200],
        ),
        title: Obx(() {
          if (controller.isLoading.value) {
            return const Text(
              "Loading...",
              style: TextStyle(color: Colors.grey),
            );
          }
          return Text(
            controller.name.value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        }),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("@${user.username}"),
            const SizedBox(height: 4),
            Obx(() {
              if (controller.isLoading.value) {
                return const SizedBox(
                  height: 10,
                  width: 100,
                  child: LinearProgressIndicator(minHeight: 2),
                );
              }
              return Text(
                controller.location.value,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              );
            }),
          ],
        ),
        onTap: () {
          if (!controller.isLoading.value) {
            Get.to(() => UserDetailView(user: user));
          }
        },
      ),
    );
  }
}
