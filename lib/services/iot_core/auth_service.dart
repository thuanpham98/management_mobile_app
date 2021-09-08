


import 'package:management/services/iot_core/constant.dart';
import 'package:web_socket_channel/io.dart';
import 'package:get_it/get_it.dart';
import '../../blocs/auth/user_repository.dart';

class AuthService {

  static IOWebSocketChannel? _channel;
  static String _token = "" ;
  static AuthService? _instance;
  
  static AuthService getInstance() {
    if(_instance==null){
      _instance = AuthService();
    }
    return _instance!;
  }

  Future<IOWebSocketChannel> getService() async{
    if(_channel == null){
      if(_token == ""){
        _token = await GetIt.I<UserRepository>().getUserGoogleToken();
      }
      await refreshToken();
      _channel = IOWebSocketChannel.connect(Uri.parse(SERVER_WS_URL+CHANNEL_AUTH_URL),headers: {"id_token":_token});
    }
    return _channel!;
  }
  
  Future<String> getToken() async{
    if(_token == ""){
      _token = await GetIt.I<UserRepository>().getUserGoogleToken();
    }
    return _token;
  }

  Future<void> refreshToken() async{
      _token = await GetIt.I<UserRepository>().getUserGoogleToken();
  }

  static Future<void> clearService() async{
    _channel =null;
    _token="";
  }
}