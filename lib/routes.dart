import 'package:get/get.dart';
import 'views/home.dart';

class Routes {
  static const String home = '/home';

  static List<GetPage> pages = [
    GetPage(name: home, page: () => HomePage()),
  ];
}
