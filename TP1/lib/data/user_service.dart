import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user.dart';

class UserService {
  static const String _kEmailKey = 'current_user_email';
  static const String _kNameKey = 'current_user_name';

  // SP SAVE
  Future<void> saveCurrentUser(User user) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_kEmailKey, user.email ?? '');
    await sp.setString(_kNameKey, user.fullName ?? '');
    print('EEEE SAHA ${user.fullName ?? 'chkounek?'}');
  }

  // SP GET
  Future<User?> getCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    final email = sp.getString(_kEmailKey);
    final name = sp.getString(_kNameKey);

    if (email == null && name == null) {
      return null; 
    }
    print('Success!!!');
    return User(email: email, fullName: name);
  }

  // SP CLEAR
  Future<void> clearCurrentUser() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_kEmailKey);
    await sp.remove(_kNameKey);
    print('Local user cleared');
  }
}
