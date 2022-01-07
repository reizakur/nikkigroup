part of 'shared_preferences.dart';

class UserData {
  static const String logstatus_str = "status_log_key";
  static const String username_str = "username_key";
  static const String password_str = "password_key";
  static const String role_id_str = "role_id_key";
  static const String role_name_str = "role_name_key";
  static const String ClientID_str = "ClientID_key";
  static const String UserID_str = "user_id_key";

  //
  static bool _statusLog = false;
  static String _username = 'No Data avail';
  static String _password = 'No Data avail';
  static String _currentRoleID = 'No Data avail';
  static String _clientID = 'No Data avail';
  static String _userID = 'No Data avail';
  static String _currentRoleName = 'No Data avail';

  static String getUsername() {
    return _username;
  }

  static String getUsercurrentRoleName() {
    return _currentRoleName;
  }

  static bool getStatusLog() {
    return _statusLog;
  }

  static String getPassword() {
    return _password;
  }

  static String getUserCurrentRoleID() {
    return _currentRoleID;
  }

  static String getClientID() {
    return _clientID;
  }

  static String getUserID() {
    return _userID;
  }

  static void printdevinfo() {
    print("\n\n======[info]=======]");
    print("username  : $_username");
    print("password  : $_password");
    print("Role ID   : $_currentRoleID");
    print("Role name : $_currentRoleName");
    print("Client ID : $_clientID");
    print("User ID : $_userID");
    print("Log status: $_statusLog");
    print("===================]\n\n");
  }

  static Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    const String nodata = 'No Data Avail';
    pref.setString(UserData.username_str, nodata);
    pref.setString(UserData.password_str, nodata);
    pref.setString(UserData.role_id_str, nodata);
    pref.setString(UserData.role_name_str, nodata);
    pref.setString(UserData.ClientID_str, nodata);
    pref.setString(UserData.UserID_str, nodata);
    pref.setBool(UserData.logstatus_str, false);
    await getPref();
    print('[Account dev] : Data wiped out');
    printdevinfo();
  }

  static Future<void> setUserID({@required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(UserData.UserID_str, id);
    await getPref();
    print('[LOGIN INFO] : Updated..!');
    printdevinfo();
    return;
  }

  static Future<void> setCurrentRole({@required AccountRoles setRole}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(UserData.role_id_str, setRole.adRoleID);
    pref.setString(UserData.role_name_str, setRole.roleName);
    await getPref();
    print('[LOGIN INFO] : Updated..!');
    printdevinfo();
    return;
  }

  static Future<void> signIn({
    @required String username,
    @required String password,
    @required String clientID,
    @required String roleID,
    @required String roleName,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(UserData.username_str, username);
    pref.setString(UserData.password_str, password);
    pref.setString(UserData.ClientID_str, clientID);
    pref.setString(UserData.role_id_str, roleID);
    pref.setString(UserData.role_name_str, roleName);

    pref.setBool(UserData.logstatus_str, true);
    await getPref();
    return;
  }

  static Future<void> getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _username = pref.getString(username_str).toString();
    _password = pref.getString(password_str).toString();
    _userID = pref.getString(UserID_str).toString();
    _currentRoleID = pref.getString(role_id_str).toString();
    _currentRoleName = pref.getString(role_name_str).toString();
    _clientID = pref.getString(ClientID_str).toString();
    if (pref.getBool(logstatus_str) == null ||
        pref.getBool(logstatus_str) == false) {
      _statusLog = false;
    } else {
      _statusLog = true;
    }
    return;
  }
}
