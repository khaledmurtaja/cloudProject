import 'package:get/get.dart';
import '../../../core/values/roles.dart';
import '../../../routes/routes.dart';
import '../../data/services/sharedPrefService.dart';

class LoginPageMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig> redirectDelegate(GetNavConfig route) async {
    String? role = "";
    AppSharedPref appSharedPref = Get.find<AppSharedPref>();
    role = await appSharedPref.getStringValue(key: "userrole");
    print("f");
    print(role);
print(await appSharedPref.getStringValue(key: "Uid"));
    if (role == null || role == "") {
      return route;
    } else {
      if (role == Roles.trainee) {
        return Get.rootDelegate.toNamed(Routes.TRAINEE_HOME);
      } else if (role == Roles.advisor) {
        return Get.rootDelegate.toNamed(Routes.ADVISOR_HOME);
      } else {
        return Get.rootDelegate.toNamed(Routes.MANEGER_HOME);
      }
    }
  }
}
