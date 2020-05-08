import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPrimission {
  static checkPermisson(Map<PermissionGroup, PermissionStatus> permissions) {
    switch (permissions[PermissionGroup.location]) {
      //同意
      case PermissionStatus.granted:
        return true;
        break;
      //拒绝,默认是拒绝以及第一次请求拒绝
      case PermissionStatus.denied:
      //拒绝并且禁止在此弹窗
      case PermissionStatus.neverAskAgain:
      case PermissionStatus.restricted:
      case PermissionStatus.unknown:
      default:
        return false;
        break;
    }
  }

  static Future<bool> getLocationPermission() async {
    PermissionStatus permissionStatus = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    switch (permissionStatus) {
      //拒绝,默认是拒绝以及第一次请求拒绝
      case PermissionStatus.denied:
        Map<PermissionGroup, PermissionStatus> permissions =
            await PermissionHandler()
                .requestPermissions([PermissionGroup.location]);
        return checkPermisson(permissions);
        break;
      //同意
      case PermissionStatus.granted:
        return true;
        break;
      //拒绝并且禁止在此弹窗
      case PermissionStatus.neverAskAgain:
      case PermissionStatus.restricted:
      case PermissionStatus.unknown:
      default:
        return false;
        break;
    }
    return true;
  }
}
