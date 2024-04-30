import '../common_model/common_response.dart';
import 'base_network.dart';

class DataSource {
  static DataSource instance = DataSource();

  static const String registerAPI = 'register';
  static const String verifyOTPAPI = 'verify-otp';
  static const String changeEmailAPI = 'change-email';
  static const String resendOTPAPI = 'resend-otp';
  static const String KYCVerificationAPI = 'kyc-verification';
  static const String loginAPI = 'login';
  static const String userGetAPI = 'users';
  static const String logoutAPI = 'logout';

  Future<CommonResponse?> register({required Map<String,dynamic> body, required bool isMultiPart}) {
    return BaseNetwork.post(registerAPI,body: body,isForLogin: false,isMultiPart: isMultiPart);
  }

  Future<CommonResponse?> verifyOTP({required Map<String,dynamic> body}) {
    return BaseNetwork.post(verifyOTPAPI,body: body);
  }

  Future<CommonResponse?> changeEmail({required Map<String,dynamic> body}) {
    return BaseNetwork.post(changeEmailAPI,body: body);
  }

  Future<CommonResponse?> resendOTP({required Map<String,dynamic> body}) {
    return BaseNetwork.post(resendOTPAPI,body: body);
  }

  Future<CommonResponse?> KYCVerification({required Map<String,dynamic> body,}) {
    return BaseNetwork.post(KYCVerificationAPI,body: body,isMultiPart: true);
  }

  Future<CommonResponse?> login({required Map<String,dynamic> body}) {
    return BaseNetwork.post(loginAPI,body: body);
  }

  Future<CommonResponse?> logout({required Map<String,dynamic> body}) {
    return BaseNetwork.post(logoutAPI,body: body);
  }

  Future<CommonResponse?> userGet() {
    return BaseNetwork.get(userGetAPI);
  }
}
