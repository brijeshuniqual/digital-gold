import 'package:untitled/screens/bottom_navigation_screen_module/bottom_navigation_screen_controller.dart';

import '../../constants/app.export.dart';

class LandingPage extends StatelessWidget {
  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24)),
            boxShadow: [
              BoxShadow(color: ColorRes.textGreyColor.withOpacity(0.5), spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: landingPageController.changeTabIndex,
              currentIndex: landingPageController.tabIndex.value,
              backgroundColor: ColorRes.whiteColor,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: TextStyle(
                decoration: TextDecoration.none,
                color: ColorRes.textGreyColor,
                fontSize: Utils.getFontSize(14),
                fontWeight: (FontWeight.w500),
                fontFamily: ("Inter"),
                letterSpacing: 0.1,
              ),
              selectedLabelStyle: TextStyle(
                decoration: TextDecoration.none,
                color: ColorRes.primaryColor,
                fontSize: Utils.getFontSize(14),
                fontWeight: (FontWeight.w500),
                fontFamily: ("Inter"),
                letterSpacing: 0.1,
              ),
              items: [
                BottomNavigationBarItem(
                  backgroundColor: ColorRes.whiteColor,
                  icon: getBottomIcon("Recipes", "recipes_unselected"),
                  activeIcon: getBottomIcon("Recipes", "recipes_selected"),
                  label: 'Recipes',
                ),
                BottomNavigationBarItem(
                  backgroundColor: ColorRes.whiteColor,
                  icon: getBottomIcon("Pantry", "pantry_unselected"),
                  activeIcon: getBottomIcon("Pantry", "pantry_selected"),
                  label: 'Pantry',
                ),
                BottomNavigationBarItem(
                  backgroundColor: ColorRes.whiteColor,
                  icon: getBottomIcon("Grocery List", "grocery_list_unselected"),
                  activeIcon: getBottomIcon("Grocery List", "grocery_list_selected"),
                  label: 'Grocery List',
                ),
                BottomNavigationBarItem(
                  backgroundColor: ColorRes.whiteColor,
                  icon: getBottomIcon("Profile", "profile_unselected"),
                  activeIcon: getBottomIcon("Profile", "profile_selected"),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController = Get.put(LandingPageController(), permanent: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => getScreenWidget(tabItem : landingPageController.tabIndex.value.toString())),
    );
  }

  getScreenWidget({
    String? tabItem,
    LandingPageController? controller,
  }) {
    Widget child;
    if (tabItem == "0") {
      child = Container();
    } else if (tabItem == "1") {
      child = Container();
    } else if (tabItem == "2") {
      child = Container();
    } else if (tabItem == "3") {
      child = Container();
    } else {
      child = Container();
    }
    return child;
  }

  getBottomIcon(String title, String image, {bool isSelected = false}) {
    return Column(
      children: [
        // BaseText(text: title, fontSize: 14, fontWeight: FontWeight.w500,color: isSelected ? ColorRes.primaryColor : ColorRes.textColor,),
        Container(
          margin: EdgeInsets.only(bottom: Utils.getSize(5)),
          height: Utils.getSize(24),
          width: Utils.getSize(24),
          child: Center(child: Image.asset(Utils.getAssetsImg(image))),
        )
      ],
    );
  }
}
