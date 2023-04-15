class StringUtils {
  static String capitalizeFirst(String text) {
    if (text.isEmpty) {
      return text;
    }
    List<String> split = text.trim().split(' ');
    if (split.isEmpty) {
      split = text.trim().split('');
      return text;
    }

    final List<String> newList = split.map((String st) {
      if (st.isNotEmpty) {
        return '${st[0].toUpperCase()}${st.substring(1, st.length).toLowerCase()}';
      } else {
        return '';
      }
    }).toList();
    return newList.join(' ');
  }

  static String formatName(String text) {
    if (text.isEmpty) {
      return text;
    }

    final List<String> split = text.trim().split('-');
    if (split.isEmpty) {
      return text;
    }

    final List<String> newList = split.map((String st) {
      if (st.isEmpty) {
        return '';
      }
      if (st.length == 1) {
        return st[0].toUpperCase();
      }
      return '${st[0].toUpperCase()}${st.substring(1, st.length).toLowerCase()}';
    }).toList();
    return newList.join('-');
  }

  static String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(RegExp(' +')).map((String s) => s[0]).take(2).join()
      : '';

  static bool checkSpecialChar(String str) {
    final RegExp pattern = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return pattern.hasMatch(str);
  }
}
