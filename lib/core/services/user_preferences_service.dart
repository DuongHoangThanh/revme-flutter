import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  static const String _walletAddressKey = 'wallet_address';
  static const String _walletPrivateKeyKey = 'wallet_private_key';
  static const String _nameKey = 'user_name';
  static const String _phoneKey = 'user_phone';
  static const String _addressKey = 'shipping_address';
  static const String _cityKey = 'user_city';
  static const String _hasCompletedOnboardingKey = 'has_completed_onboarding';

  // Lưu địa chỉ ví
  static Future<void> saveWalletAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_walletAddressKey, address);
  }

  // Lấy địa chỉ ví
  static Future<String?> getWalletAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletAddressKey);
  }

  // Lưu thông tin người dùng
  static Future<void> saveUserInfo({
    required String name,
    required String phone,
    required String address,
    required String city,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_phoneKey, phone);
    await prefs.setString(_addressKey, address);
    await prefs.setString(_cityKey, city);
  }

  // Lấy tên người dùng
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nameKey);
  }

  // Lấy số điện thoại
  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneKey);
  }

  // Lấy địa chỉ giao hàng
  static Future<String?> getShippingAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_addressKey);
  }

  // Lấy thành phố
  static Future<String?> getUserCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_cityKey);
  }

  // Đánh dấu là đã hoàn thành onboarding
  static Future<void> setOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasCompletedOnboardingKey, true);
  }

  // Kiểm tra xem đã hoàn thành onboarding chưa
  static Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasCompletedOnboardingKey) ?? false;
  }

  // Kiểm tra địa chỉ ví có hợp lệ không
  static bool isValidEthereumAddress(String address) {
    // Kiểm tra định dạng: 0x + 40 ký tự hex
    RegExp ethAddressRegExp = RegExp(r'^0x[a-fA-F0-9]{40}$');
    return ethAddressRegExp.hasMatch(address);
  }
  
  // Lấy tất cả thông tin người dùng
  static Future<Map<String, String?>> getAllUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'walletAddress': prefs.getString(_walletAddressKey),
      'name': prefs.getString(_nameKey),
      'phone': prefs.getString(_phoneKey),
      'address': prefs.getString(_addressKey),
      'city': prefs.getString(_cityKey),
    };
  }
  
  // Kiểm tra xem đã nhập đủ thông tin chưa
  static Future<bool> hasCompletedProfile() async {
    final walletAddress = await getWalletAddress();
    final name = await getUserName();
    final address = await getShippingAddress();
    
    return walletAddress != null && walletAddress.isNotEmpty && 
           name != null && name.isNotEmpty &&
           address != null && address.isNotEmpty;
  }

  // Xóa tất cả thông tin người dùng
  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_walletAddressKey);
    await prefs.remove(_nameKey);
    await prefs.remove(_phoneKey);
    await prefs.remove(_addressKey);
    await prefs.remove(_cityKey);
    await prefs.remove(_hasCompletedOnboardingKey);
    await prefs.remove(_walletPrivateKeyKey);
  }

  // Lưu private key
  static Future<void> saveWalletPrivateKey(String privateKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_walletPrivateKeyKey, privateKey);
  }

  // Lấy private key
  static Future<String?> getWalletPrivateKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletPrivateKeyKey);
  }
}
