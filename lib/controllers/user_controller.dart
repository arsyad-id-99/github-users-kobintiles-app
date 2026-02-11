import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/helpers/db_helper.dart';
import 'package:github_user_kobintiles_app/models/user_model.dart';
import 'package:github_user_kobintiles_app/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserController extends GetxController {
  var userList = <User>[].obs;
  var favoriteList = <User>[].obs;
  var isLoading = false.obs;

  int _lastId = 0;
  final int _perPage = 20;
  bool _hasMore = true;

  ScrollController scrollController = ScrollController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    loadFavorites();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchUsers();
      }
    });
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isLoading.value || !_hasMore) return;

    if (isRefresh) {
      _lastId = 0;
      _hasMore = true;
      userList.clear();
    }

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse(
          'https://api.github.com/users?since=$_lastId&per_page=$_perPage',
        ),
        headers: {
          'Authorization': 'Bearer $GITHUB_TOKEN',
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        if (jsonResponse.isEmpty) {
          _hasMore = false;
        } else {
          List<User> newUsers = jsonResponse
              .map((data) => User.fromJsonList(data))
              .toList();

          userList.addAll(newUsers);
          _lastId = newUsers.last.id!;
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<User?> fetchUserDetail(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $GITHUB_TOKEN',
          'Accept': 'application/vnd.github.v3+json',
        },
      );
      if (response.statusCode == 200) {
        return User.fromJsonDetail(json.decode(response.body));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching detail: $e");
      }
    }
    return null;
  }

  Future<void> loadFavorites() async {
    favoriteList.value = await _dbHelper.getFavorites();
  }

  Future<void> toggleFavorite(User user) async {
    bool isFav = await _dbHelper.isFavorite(user.id!);
    if (isFav) {
      await _dbHelper.deleteFavorite(user.id!);
      Get.snackbar("Info", "${user.username} dihapus dari favorit");
    } else {
      await _dbHelper.insertFavorite(user);
      Get.snackbar("Success", "${user.username} ditambahkan ke favorit");
    }
    loadFavorites();
  }

  Future<bool> checkIsFavorite(int id) async {
    return await _dbHelper.isFavorite(id);
  }
}
