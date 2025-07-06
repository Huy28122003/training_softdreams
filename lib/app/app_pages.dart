import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:training_softdreams/presentation/pages/animal/binding/animal_binding.dart';
import 'package:training_softdreams/presentation/pages/animal/view/animal_view.dart';
import 'package:training_softdreams/presentation/pages/auth/binding/auth_binding.dart';
import 'package:training_softdreams/presentation/pages/auth/view/auth_view.dart';
import '../presentation/pages/demo_getx/binding/demo_getx_binding.dart';
import '../presentation/pages/demo_getx/view/demo_getx_view.dart';
import '../presentation/pages/demo_provider/demo_provider_screen.dart';
import '../presentation/pages/demo_provider/service/demo_provider_service.dart';
import '../presentation/pages/screens.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.demoBloc,
      page: () {
        final arg = Get.arguments as int;
        return BlocProvider(
          create: (_) => DemoBlocBloc()..initialize(arg),
          child: DemoBlocScreen(),
        );
      },
    ),
    GetPage(
      name: AppRoutes.demoCubit,
      page: () => BlocProvider(
        create: (_) => DemoCubit(),
        child: DemoCubitScreen(),
      ),
    ),
    GetPage(
        name: AppRoutes.demoGetX,
        page: () => DemoGetXView(),
        binding: DemoGetXBinding()),
    GetPage(
      name: AppRoutes.demoProvider,
      page: () => ChangeNotifierProvider<DemoProviderService>(
        create: (_) => DemoProviderService(),
        child: const DemoProviderScreen(),
      ),
    ),
    GetPage(
      name: AppRoutes.auth,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.animal,
      page: () => AnimalView(),
      binding: AnimalBinding(),
    ),
  ];
}
