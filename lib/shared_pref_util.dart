import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  SharedPreferences pref;

  SharedPrefUtil() {
    SharedPreferences.getInstance().then((value) => pref = value);
  }
}
