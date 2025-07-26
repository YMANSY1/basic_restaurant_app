import 'package:get/get.dart';

class MenuController extends GetxController {
  final _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  void selectCategory(int index) {
    _selectedIndex.value = index;
  }
}
