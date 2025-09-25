class StringHelper {
  static bool isBlank(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static bool isNotBlank(String? value) {
    return value != null && value.trim().isNotEmpty;
  }
}
