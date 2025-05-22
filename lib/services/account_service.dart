abstract class AccountService {
  Future<void> logIn(String username, String password);

  Future<void> signUp(
    String username,
    String password,
    String? email,
    String? mobile,
    String? avatar,
    String? birthday,
  );

  Future<bool> isLoggedIn();

  Future<void> logOut();
}
