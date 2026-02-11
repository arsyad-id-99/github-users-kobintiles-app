import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/controllers/user_controller.dart';
import 'package:github_user_kobintiles_app/views/widgets/user_card.dart';

class UserListView extends StatelessWidget {
  final UserController controller;
  const UserListView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.fetchUsers(isRefresh: true),
      child: Obx(() {
        if (controller.userList.isEmpty && controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          controller: controller.scrollController,
          itemCount:
              controller.userList.length +
              1, // +1 for loading indicator at bottom
          itemBuilder: (context, index) {
            if (index == controller.userList.length) {
              return controller.isLoading.value
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : const SizedBox.shrink();
            }
            final user = controller.userList[index];
            return UserCard(user: user, isFromApi: true);
          },
        );
      }),
    );
  }
}
