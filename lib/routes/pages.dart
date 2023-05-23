import 'package:get/route_manager.dart';
import 'package:getx_architecture/App/modules/traineeHome/page.dart';
import 'package:getx_architecture/routes/routes.dart';

import '../App/modules/TraineeProfile/binding.dart';
import '../App/modules/TraineeProfile/page.dart';
import '../App/modules/advisorHome/advisorHomeScreen.dart';
import '../App/modules/advisorTrainees/binding.dart';
import '../App/modules/advisorTrainees/page.dart';
import '../App/modules/login/binding.dart';
import '../App/modules/login/page.dart';
import '../App/modules/manegerHome/binding.dart';
import '../App/modules/manegerHome/page.dart';
import '../App/modules/traineeLearning/binding.dart';
import '../App/modules/traineeLearning/page.dart';
import '../App/modules/register/binding.dart';
import '../App/modules/register/page.dart';
import '../App/modules/review/requestReview.dart';
import '../App/modules/traineeHome/binding.dart';
import '../App/modules/trainingBooking/binding.dart';
import '../App/modules/trainingBooking/page.dart';
import '../App/modules/trainingDetails/binding.dart';
import '../App/modules/trainingDetails/page.dart';

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
    GetPage(
      name: Routes.TRAINEE_HOME,
      page: () => const TraineeHomeScreen(),
      binding: TraineeHomeBinding(),
    ),
    GetPage(
      name: Routes.TRAINING_BOOKING,
      page: () => TrainingBookingScreen(),
      binding: TrainingBookingBinding(),
    ),
    GetPage(
      name: Routes.ADVISOR_TRAINEES,
      page: () => AdvisorTraineesScreen(),
      binding: AdvisorTraineesBinding(),
    ),
    GetPage(
      name: Routes.TRAINEE_LEARNING,
      page: () => TraineeLearningScreen(),
      binding: TraineeLearninBinding(),
    ),
    GetPage(
      name: Routes.TRAINEE_PROFILE,
      page: () => TraineeProfileScreen(),
      binding: TraineeProfileBinding(),
    ),
    GetPage(
      name: Routes.TRAINING_DETAILS,
      page: () => TrainingDetaileScreen(),
      binding: TrainingDetaileBinding(),
    ),
  ];
}
