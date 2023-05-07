import 'package:get/route_manager.dart';
import 'package:getx_architecture/App/modules/AddTraining/binding.dart';
import 'package:getx_architecture/App/modules/traineeHome/traineeHomeScreen.dart';
import 'package:getx_architecture/routes/routes.dart';

import '../App/modules/AddTraining/page.dart';
import '../App/modules/advisorHome/advisorHomeScreen.dart';
import '../App/modules/login/binding.dart';
import '../App/modules/login/page.dart';
import '../App/modules/manegerHome/binding.dart';
import '../App/modules/manegerHome/page.dart';
import '../App/modules/register/binding.dart';
import '../App/modules/register/page.dart';
import '../App/modules/review/requestReview.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterScreen(),
        binding: RegisterBinding()),
    GetPage(name: Routes.REVIEW, page: () => const ReviewScreen()),
    GetPage(name: Routes.ADVISOR_HOME, page: () => const AdvisorHomesScreen()),
    GetPage(
        name: Routes.MANEGER_HOME,
        page: () => const ManegerHomesScreen(),
        binding: ManegerHomeBinding()),
    GetPage(name: Routes.TRAINEE_HOME, page: () => const TraineeHomeScreen()),
    GetPage(name: Routes.ADD_TRAINING, page: ()=>const AddTrainingScreen(),binding: AddTrainingScreenBinding())
  ];
}
