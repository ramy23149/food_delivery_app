import 'package:food_delivery_app/Core/widgets/bottomNav_bar.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/password_recavory.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/food_detalis_view.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:food_delivery_app/featurs/on_boarding/presentation/views/on_bording_view.dart';
import 'package:food_delivery_app/featurs/splash/Presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../featurs/admin/Presentation/views/admin_home.dart';
import '../featurs/admin/Presentation/views/admin_view.dart';
import '../featurs/auth/data/models/update_passowrd_model.dart';
import '../featurs/auth/data/models/verificatoin_data_model.dart';
import '../featurs/auth/presentation/views/create_new_password_view.dart';
import '../featurs/auth/presentation/views/login_view.dart';
import '../featurs/auth/presentation/views/otp_verification_view.dart';
import '../featurs/auth/presentation/views/signUp_view.dart';
import '../featurs/auth/presentation/views/slect_role_view.dart';
import '../featurs/order/views/order_view.dart';

abstract class AppRouter {
  static String kfoodDetalis = '/foodDetalis';
  static String kSignUpView = '/SignInViewBody';
  static String kLogInView = '/logInView';
  static String kBottomNavBar = '/BottomNavBar';
  static String kPasswordRecavory = '/PasswordRecavory';
  static String kAdminView = '/AdminView';
  static String kAdminHome = '/AdminHome';
  static String kCartView = '/CartView';
  static String kSelectRoleView = '/SelectRoleView';
  static String kVerifyView = '/VerifyView';
  static String kCreateNewPasswordView = '/CreateNewPasswordView';
  static String kSplashView = '/';

  static final router = GoRouter(
    initialLocation: kSplashView,
    routes: <RouteBase>[
      GoRoute(
        path: kLogInView,
        builder: (context, state) {
          return const LogInView();
        },
      ),
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(path: kAdminView, builder: (context, state) => const AdminView()),
      GoRoute(path: kCartView, builder: (context, state) => const OrderView()),
    
      // GoRoute(
      //   path: kBottomNavBar, // Route for BottomNavBar
      //   builder: (context, state) {
      //     if (FirebaseAuth.instance.currentUser != null) {
      //       return const BottomNavBar();
      //     } else {
      //       return const OnBordingView();
      //     }
      //   },
      // ),
      GoRoute(
        path: kAdminHome,
        builder: (context, state) => const HomeAdmin(),
      ),
      GoRoute(
        path: kBottomNavBar,
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
        path: kPasswordRecavory,
        builder: (context, state) => const PasswordRecavory(),
      ),
      GoRoute(
          path: kfoodDetalis,
          builder: (context, state) {
            final productModel = state.extra! as ProductModel;
            return FoodDetalisView(
              productModel: productModel,
            );
          }),
      GoRoute(
        path: kSelectRoleView,
        builder: (context, state) => const SlectRoleView(),
      ),
      GoRoute(
          path: kVerifyView,
          builder: (context, state) {
            final data = state.extra as VerificatoinDataModel;
            return VerifyView(
              data: data,
            );
          }),
      GoRoute(
          path: kCreateNewPasswordView,
          builder: (context, state) {
            final updatePassowrdModel = state.extra as UpdatePassowrdModel;
            return CreateNewPasswordView(
                updatePasswordModel: updatePassowrdModel);
          })
    ],
  );
}
