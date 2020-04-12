import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {
  static Future<PermissionStatus> requestStoragePermission() async {
    return await Permission.storage.request();
  }
  static Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }
}