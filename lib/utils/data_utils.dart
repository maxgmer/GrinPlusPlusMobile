import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
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

  static Future<Directory> getTransactionsDirectory() async {
    String rootPath = await getPathWhereAppDirIsPlaced();
    Directory directory = Directory('$rootPath${DotEnv().env['TRANSACTIONS_FOLDER']}');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  static Future<String> getPathWhereAppDirIsPlaced() async {
    Directory directory;
    if (Platform.isAndroid) {
      List<StorageInfo> info = await PathProviderEx.getStorageInfo();
      if (info.length != 0) {
        directory = Directory(info[0].rootDir);
      } else {
        directory = await getExternalStorageDirectory();
      }
    }
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    }
    return directory.path;
  }
}