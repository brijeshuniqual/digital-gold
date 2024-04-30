import '../../constants/app.export.dart';

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;
  RxList<CommonModel> bottomOptions = [
    CommonModel(unSelectedImage: "recipes_unselected", image: "recipes_selected", title: 'Recipes',),
    CommonModel(unSelectedImage: "pantry_unselected", image: "pantry_selected", title: 'Pantry',),
    CommonModel(unSelectedImage: "grocery_list_unselected", image: "grocery_list_selected", title: 'Grocery List',),
    CommonModel(unSelectedImage: "profile_unselected", image: "profile_selected", title: 'Profile',),
  ].obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
