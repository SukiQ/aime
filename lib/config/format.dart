
import 'package:intl/intl.dart';

class FormatConfig {
  static final DateFormat dateFormat = DateFormat('yyyy/MM/dd');
  static final RegExp usernameFormat = RegExp(r"^[\p{L}·\.\-\s]{2,50}$", unicode: true);
}