part of 'idempiere_service.dart';

abstract class AccountWS {
  LoginRequest _login;
  WebServiceConnection _client;

  AccountWS() {
    _login = new LoginRequest();
    _login.setUser = 'mobile.app';
    _login.setPass = 'penguin';
    _login.setClientID = 1000000;
    _login.setRoleID = 1000127;
    _login.setOrgID = 0;
    _login.setStage = 0;

    _client = new WebServiceConnection();
    _client.setAttempts = 3;
    _client.setTimeout = 5000;
    _client.setAttemptsTimeout = 5000;
    _client.setUrl = 'http://101.255.95.211:41';
    _client.setAppName = 'Java Test WS Client';
    //runTest();
  }

  LoginRequest get getLogin => _login;

  WebServiceConnection get getClient => _client;

  String getWebServiceType();

  Future<void> testPerformed();
}

abstract class GeneralWS {
  LoginRequest _login;
  WebServiceConnection _client;

  GeneralWS() {
    _login = new LoginRequest();
    _login.setUser = UserData.getUsername();
    _login.setPass = UserData.getPassword();
    _login.setClientID = 1000000;
    _login.setRoleID = int.parse(UserData.getUserCurrentRoleID());
    _login.setOrgID = 0;
    _login.setStage = 0;

    _client = new WebServiceConnection();
    _client.setAttempts = 3;
    _client.setTimeout = 5000;
    _client.setAttemptsTimeout = 5000;
    _client.setUrl = 'http://101.255.95.211:41';
    _client.setAppName = 'Java Test WS Client';
    //runTest();
  }
  LoginRequest get getLogin => _login;

  WebServiceConnection get getClient => _client;

  String getWebServiceType();
}
