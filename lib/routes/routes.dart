import 'package:get/get.dart';
import 'package:mangak/screens/detail/mangadetailcontroller.dart';
import 'package:mangak/screens/feed/feed.dart';
import 'package:mangak/screens/feed/feedcontroller.dart';
import 'package:mangak/screens/genres/genres.dart';
import 'package:mangak/screens/genres/genrescontroller.dart';
import 'package:mangak/screens/home/home.dart';
import 'package:mangak/screens/home/homecontroller.dart';
import 'package:mangak/screens/login/login.dart';
import 'package:mangak/screens/login/logincontroller.dart';
import 'package:mangak/screens/profile/profile.dart';
import 'package:mangak/screens/profile/profilecontroller.dart';
import 'package:mangak/screens/register/register.dart';
import 'package:mangak/screens/register/registercontroller.dart';
import 'package:mangak/screens/search/search.dart';
import 'package:mangak/screens/search/searchcontroller.dart';
import 'package:mangak/screens/splash/splash_view.dart';
import 'package:mangak/screens/splash/splashcontroller.dart';

import '../screens/detail/mangadetail.dart';

abstract class Routes {
  static const home = '/home';
  static const detail = '/mangadetail';
  static const feed = '/feed';
  static const profile = '/profile';
  static const search = '/search';
  static const login = '/login';
  static const register = '/register';
  static const genres = '/genres';
  static const splash = '/splash';
}

abstract class AppPages {
  static String initial = Routes.splash;
  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const Home(),
        binding: BindingsBuilder.put(() => HomeController())),
    GetPage(
        name: Routes.detail,
        page: () => const MangaDetail(),
        binding: BindingsBuilder.put(() => DetailController())),
    GetPage(
        name: Routes.feed,
        page: () => const Feed(),
        binding: BindingsBuilder.put(() => FeedController())),
    GetPage(
        name: Routes.profile,
        page: () => const Profile(),
        binding: BindingsBuilder.put(() => ProfileController())),
    GetPage(
        name: Routes.search,
        page: () => const SearchScreen(),
        binding: BindingsBuilder.put(() => SearchController())),
    GetPage(
        name: Routes.login,
        page: () => const LoginScreen(),
        binding: BindingsBuilder.put(() => LoginController())),
    GetPage(
        name: Routes.register,
        page: () => const Register(),
        binding: BindingsBuilder.put(() => RegisterController())),
    GetPage(
        name: Routes.genres,
        page: () => const Genres(),
        binding: BindingsBuilder.put(() => GenresController())),
    GetPage(
        name: Routes.splash,
        page: () => const SplashView(),
        binding: BindingsBuilder.put(() => SplashController())),
  ];
}
