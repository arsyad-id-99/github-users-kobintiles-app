import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/controllers/user_controller.dart';
import 'package:github_user_kobintiles_app/models/user_model.dart';

class UserDetailView extends StatefulWidget {
  final User user;
  const UserDetailView({super.key, required this.user});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  final UserController controller = Get.find();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  void _checkFavorite() async {
    bool status = await controller.checkIsFavorite(widget.user.id!);
    setState(() {
      isFavorite = status;
    });
  }

  void _toggleFav() async {
    await controller.toggleFavorite(widget.user);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user.username)),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleFav,
        backgroundColor: isFavorite ? Colors.red : Colors.grey,
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.user.avatarUrl),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.user.name ?? "No Name",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "@${widget.user.username}",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const Divider(height: 30),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Location"),
              subtitle: Text(widget.user.location ?? "Unknown"),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Followers"),
              subtitle: Text("${widget.user.followers ?? 0} Users"),
            ),
          ],
        ),
      ),
    );
  }
}
