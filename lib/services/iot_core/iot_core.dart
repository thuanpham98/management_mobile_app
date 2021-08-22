import 'auth_service.dart';

class IotCore {
  static AuthService? _authService;
  static IotCore? _instance;

  static IotCore getInstance() {
    if(_instance == null){
      _instance = IotCore();
    }
    return _instance!;
  }

  AuthService getAuthService(){
    if(_authService == null){
      _authService = AuthService.getInstance();
    }
    return _authService!;
  }
}