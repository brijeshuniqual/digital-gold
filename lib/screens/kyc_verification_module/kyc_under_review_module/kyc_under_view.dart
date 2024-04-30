
import 'package:untitled/constants/constant.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_under_review_module/kyc_under_controller.dart';
import 'package:untitled/screens/kyc_verification_module/kyc_verification_controller.dart';

import '../../../constants/app.export.dart';

class KYCUnderView extends StatelessWidget {
  bool isKYCUnderReview;
  KYCUnderView({super.key,required this.isKYCUnderReview});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<KYCUnderController>(
      init: KYCUnderController(),
      dispose: (_) => Get.delete<KYCUnderController>(),
      builder: (_) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: mainBody(_),
          ),
        );
      }
    );
  }

  mainBody(KYCUnderController _) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Utils.getAssetsImg('verified'),width: 100.getSize,height: 100.getSize,),
          24.heightSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 56.getSize),
            child: BasePangramText(textAlign: TextAlign.center,text: 'Your KYC is under review',fontSize: 22,fontWeight: FontWeight.w700,color: ColorRes.blackColor,),
          ),
          8.heightSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38.getSize),
            child: BasePangramText(textAlign: TextAlign.center,text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. EDIT',fontSize: 14,fontWeight: FontWeight.w500,color: ColorRes.greyColor,),
          ),
        ],
      ),
    );

  }
}
