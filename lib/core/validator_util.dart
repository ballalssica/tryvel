class ValidatorUtil {
  static String? validatorStoreName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '매장명을 입력해주세요';
    }
  }

  static String? ValidatorNickname(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '닉네임을 입력해주세요';
    }
    if (value!.length < 2) {
      return '닉네임은 2글자 이상이여야합니다';
    }
  }
}
