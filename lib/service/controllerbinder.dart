import 'package:get/get.dart';

import 'network_controller.dart';
import 'permission_controller.dart';
import 'share_receive_controller.dart';
import '../utils/constants.dart';

class PermissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PermissionController());
    Get.put(YoutubeHelper());
    Get.put(PlaylistHelper());
    Get.put(NetworkController());
    Get.put(ShareReceiveController()
    );
  }
}
