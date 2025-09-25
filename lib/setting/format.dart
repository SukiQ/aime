import 'package:intl/intl.dart';

class FormatConfig {
  static final DateFormat dateFormat = DateFormat('yyyy/MM/dd');
  static final RegExp usernameFormat = RegExp(
    r"^[\p{L}·\.\-\s]{2,50}$",
    unicode: true,
  );
  static final RegExp emailFormat = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
  );
  static final RegExp phoneFormat = RegExp(r'^\+?[0-9]{6,15}$');
}
