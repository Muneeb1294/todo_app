import 'package:get/get.dart';

import '../src/base/view/base_view.dart';
import '../src/base/view/create_todo.dart';

abstract class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: BaseView.route, page: () => const BaseView()),
    GetPage(name: CreateTodo.route, page: () => const CreateTodo()),
  ];
}
