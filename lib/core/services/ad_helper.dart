import 'dart:io';

class AdHelper {
  // ID quảng cáo test của Google
  static const String bannerAdUnitIdAndroid = 'ca-app-pub-3940256099942544/6300978111';
  static const String bannerAdUnitIdIOS = 'ca-app-pub-3940256099942544/2934735716';

  static const String interstitialAdUnitIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  static const String interstitialAdUnitIdIOS = 'ca-app-pub-3940256099942544/4411468910';

  static const String rewardedAdUnitIdAndroid = 'ca-app-pub-3940256099942544/5224354917';
  static const String rewardedAdUnitIdIOS = 'ca-app-pub-3940256099942544/1712485313';

  static String getBannerAdUnitId() {
    if (Platform.isAndroid) {
      return bannerAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return bannerAdUnitIdIOS;
    }
    return '';
  }

  static String getInterstitialAdUnitId() {
    if (Platform.isAndroid) {
      return interstitialAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return interstitialAdUnitIdIOS;
    }
    return '';
  }

  static String getRewardedAdUnitId() {
    if (Platform.isAndroid) {
      return rewardedAdUnitIdAndroid;
    } else if (Platform.isIOS) {
      return rewardedAdUnitIdIOS;
    }
    return '';
  }
}