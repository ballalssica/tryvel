class ValidatorUtil {
  static String? validatorStoreName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '매장명을 입력해주세요';
    }
  }

  static String? validatorCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '카테고리를 선택해주세요';
    }
    return null;
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
