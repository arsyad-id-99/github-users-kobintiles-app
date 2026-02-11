import 'package:get/get.dart';
import 'package:github_user_kobintiles_app/models/user_model.dart';
import 'user_controller.dart';

class UserCardController extends GetxController {
  final User user;

  var isLoading = false.obs;
  var name = ''.obs;
  var location = ''.obs;

  UserCardController(this.user);

  @override
  void onInit() {
    super.onInit();
    name.value = user.name ?? user.username;
    location.value = user.location ?? "No Location";

    if (user.name == null || user.location == null) {
      fetchDetail();
    }
  }

  void fetchDetail() async {
    isLoading.value = true;

    final UserController parentController = Get.find();
    User? res = await parentController.fetchUserDetail(user.url!);

    if (res != null) {
      name.value = res.name ?? user.username;
      location.value = res.location ?? "Unknown";

      user.name = res.name;
      user.location = res.location;
      user.followers = res.followers;
    }

    isLoading.value = false;
  }
}
