import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'account_service.dart';

class AccountServiceMock extends GetxService implements AccountService {
  late FlutterSecureStorage _secureStorage;

  final _accessTokenKey = 'access_token';

  @override
  void onInit() {
    _secureStorage = Get.find();
    super.onInit();
  }

  @override
  Future<void> logIn(String username, String password) async {
    await 3.delay(); // simulate api calling
    // simulate user enter invalid username or password
    if (username != 'demo' || password != 'Qweqwe!2') {
      throw 'Incorrect username or password';
    }
    await _secureStorage.write(key: _accessTokenKey, value: 'demo_access_token'); // write token to secure storage
  }

  @override
  Future<void> signUp(
    String username,
    String password,
    String? email,
    String? mobile,
    String? avatar,
    String? birthday,
  ) async {
    await 3.delay(); // simulate api calling
    // simulate user enter invald username
    if (username != 'demo') {
      throw 'Invalid username';
    }
    // simulate user enter invald password
    if (password != 'Qweqwe!2') {
      throw 'Invalid password';
    }
    await _secureStorage.write(key: _accessTokenKey, value: 'demo_access_token'); // write token to secure storage
  }

  @override
  Future<bool> isLoggedIn() async {
    await 3.delay(); // simulate api calling
    var token = await _secureStorage.read(key: _accessTokenKey); // read access token from secure storage
    return token != null; // user is logged in when token is not null
  }

  @override
  Future<void> logOut() async {
    await 3.delay(); // simulate api calling
    await _secureStorage.delete(key: _accessTokenKey); // delete access token when user finish log out
  }
}
