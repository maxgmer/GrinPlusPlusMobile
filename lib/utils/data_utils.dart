import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static SharedPreferences _prefs;

  static const _divisor = '/';
  static const _walletLoginTimePrefix = 'walletLoginTime';

  static init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  static String loadWalletLatestLoginTime(String walletName) {
    try {
      return _prefs.get(_walletLoginTimePrefix + _divisor + walletName);
    } catch (error) {
      print('Exception occured: $error');
      return null;
    }
  }


  static Future updateWalletLatestLoginTime(String walletName) async {
    _prefs.setString(
      _walletLoginTimePrefix + _divisor + walletName,
      DateTime.now().toIso8601String(),
    );
  }
}