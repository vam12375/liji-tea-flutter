class MockAuthRepository {
  const MockAuthRepository();

  Future<void> sendCode(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!_isValidPhone(phone)) {
      throw const AuthException('请输入正确的手机号');
    }
  }

  Future<void> signInWithCode(String phone, String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!_isValidPhone(phone)) {
      throw const AuthException('请输入正确的手机号');
    }
    if (code.trim().length < 4) {
      throw const AuthException('请输入验证码');
    }
  }

  bool _isValidPhone(String phone) {
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    return digits.length == 11;
  }
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}
