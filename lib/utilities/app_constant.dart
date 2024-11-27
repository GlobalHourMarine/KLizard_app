import 'dart:ui';

class App {
  String appName = "GLoble Hour Marine";
  String iosLink = 'https://apps.apple.com/us/app/klizard/id6474382263';
  String androidLink =
      'https://play.google.com/store/apps/details?id=com.app.klizards&pcampaignid=web_share';
  String websiteLink = 'https://klizards.com/';
  String facebookLink = 'https://www.facebook.com/klizards';
  String instagramLink = 'https://www.instagram.com/klizards_/';
  String youtubeLink = 'https://www.youtube.com/@Klizards';
  String linkedinLink = 'https://www.linkedin.com/company/klizard-marine/';
  String googleLocationLink =
      'https://www.google.com/maps/place/KLIZARD/@30.6328634,76.7833293,13z/data=!3m1!5s0x390fead56967e1f7:0xbc1bbe7f8333df77!4m19!1m12!4m11!1m3!2m2!1d76.8240131!2d30.6326418!1m6!1m2!1s0x390feb8d8269fd3f:0x61cddb4847e0eb5e!2sUnit+29+%26+30B,+3rd+floor,+MOTIAZ+ROYAL+BUSINESS+PARK,+Zirakpur,+Gazipur,+Punjab+140603!2m2!1d76.8247036!2d30.6328155!3m5!1s0x390feb8d8269fd3f:0x61cddb4847e0eb5e!8m2!3d30.6328155!4d76.8247036!16s%2Fg%2F11scqw5gmq?hl=en-GB&entry=ttu';
  String phoneNumber = '+91-1762458122';
}

class AppColors {
  static const Color colorGradientLightMehroon =
      Color.fromRGBO(144, 44, 45, 1.0);
  static const Color colorGradienDarkMehroon = Color.fromRGBO(118, 0, 7, 1.0);

  static const Color backgroundColor = Color.fromRGBO(232, 236, 239, 1.0);
  static const Color blackColor = Color(0xFF333333);
  static const Color themeColor = colorGradientLightMehroon;
  static const Color lightgreyColor = Color.fromARGB(255, 244, 243, 243);
}

class Api {
  static const String baseURL = 'https://app.klizards.com';

  static const String baseURLv = '$baseURL/api';
  static const String login = '$baseURLv/login';
  static const String forgotPassword = '$baseURLv/forgot_password';

  static const String profile = '$baseURLv/profile';
  static const String investmentList = '$baseURLv/investment/list';
  static const String investmentDetailList = '$baseURLv/investment/detail';

  static const String videoList = '$baseURLv/video/list';
  static const String bannerList = '$baseURLv/banner/list';
  static const String profileData = '$baseURLv/profile_data';
  static const String faqList = '$baseURLv/faq/list';
  static const String updateList = '$baseURLv/updates';
  static const String pptList = '$baseURLv/ppts';

  static const String referralList = '$baseURLv/referral/list';
  static const String pptDetail = '$baseURLv/trading_pdf';
  static const String percentageDetail = '$baseURLv/percentage';
  static const String paymentModeList = '$baseURLv/payment/list';
  static const String depositList = '$baseURLv/payment/payment_requests';
  static const String depositSave = '$baseURLv/payment/request/save';
  static const String profileImage = '$baseURLv/profile/upload/image';

  static const String referralMemberList = '$baseURLv/refferal_members';
  static const String referralMemberInvestmentList =
      '$baseURLv/investment/refferal_investment';
  static const String deviceInfo = '$baseURLv/update_device_info';
}

class AppFonts {}
