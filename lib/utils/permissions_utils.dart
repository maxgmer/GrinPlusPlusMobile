import 'package:permission_handler/permission_handler.dart';

class PermissionsUtils {
  static Future<PermissionStatus> requestPermission(PermissionGroup permission) async {
    final Map<PermissionGroup, PermissionStatus> result = await PermissionHandler()
        .requestPermissions([permission]);
    return PermissionStatus.values[result[permission].value];
  }
}