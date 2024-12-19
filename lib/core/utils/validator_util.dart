class ValidatorUtil {
  static String? validatorStoreName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '매장명을 입력해주세요';
    }
    return null; // 반환 값 추가
  }

  static String? validatorCategory(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '카테고리를 선택해주세요';
    }
    return null;
  }

  static String? validatoraddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '주소를 알려주세요';
    }
    return null;
  }

  static String? validatorHoliday(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '휴일유무를 알려주세요.';
    }
    return null;
  }

  static String? validatoroperatingHoursStart(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '시작시간을 알려주세요.';
    }
    return null;
  }

  static String? validatoroperatingHoursEnd(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '종료시간을 알려주세요.';
    }
    return null;
  }

  static String? validatorparking(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '주차가능여부를 알려주세요.';
    }
    return null;
  }

  static String? validatorstoreNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '매장 전화번호를 알려주세요.';
    }
    return null;
  }

  static String? validatorStoreDiscription(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '매장소개를 입력해주세요';
    }
    if (value != null && value.length < 10) {
      return '매장소개는 10글자 이상이여야합니다';
    }
    return null;
  }

  static String? validatorNickname(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return '닉네임을 입력해주세요';
    }
    if (value != null && value.length < 2) {
      return '닉네임은 2글자 이상이여야합니다';
    }
    return null;
  }
}
