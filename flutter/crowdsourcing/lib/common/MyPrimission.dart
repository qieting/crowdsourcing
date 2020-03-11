import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPrimission {
  static checkPermisson(Map<PermissionGroup, PermissionStatus> permissions) {
    switch (permissions[PermissionGroup.location]) {
      //拒绝,默认是拒绝以及第一次请求拒绝
      case PermissionStatus.denied:
        MyToast.toast("无定位权限，请给予权限");
        return false;
        break;
      //同意
      case PermissionStatus.granted:
        return true;
        break;
      //拒绝并且禁止在此弹窗
      case PermissionStatus.neverAskAgain:
        MyToast.toast("无定位权限，请给予权限");
        return false;
        break;
      case PermissionStatus.restricted:
        return false;
        break;
      case PermissionStatus.unknown:
        return false;
        break;
      default:
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
        MyToast.toast("无定位权限，请给予权限");
        return false;
        break;
      case PermissionStatus.restricted:
        return false;
        break;
      case PermissionStatus.unknown:
        return false;
        break;
      default:
        break;
    }
    return true;
  }
}
