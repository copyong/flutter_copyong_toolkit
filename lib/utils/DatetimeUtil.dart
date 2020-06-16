import 'package:intl/intl.dart';

class DatetimeUtil {
  static const String SQL_DATETIME_FORMAT = 'yyyy-MM-dd HH:mm:ss';
  static const String SQL_DATE_FORMAT = 'yyyy-MM-dd';
  static const String DISPLAY_DATETIME_FORMAT = 'dd/MM/yyyy HH:mm:ss';
  static const String DISPLAY_DATETIME_FORMAT2 = 'dd/MM/yyyy HH:mm';
  static const String FILE_DATETIME_FORMAT = 'yyyyMMdd_HHmmssSSS';
  static const String MIN_SQL_DATETIME = '0000-00-00 00:00:00';

  static final DateFormat sqlDatetimeFmt = DateFormat(SQL_DATETIME_FORMAT);
  static final DateFormat sqlDateFmt = DateFormat(SQL_DATE_FORMAT);
  static final DateFormat displayDatetimeFmt = DateFormat(DISPLAY_DATETIME_FORMAT);
  static final DateFormat displayDatetimeFmt2 = DateFormat(DISPLAY_DATETIME_FORMAT2);
  static final DateFormat fileDatetimeFmt = DateFormat(FILE_DATETIME_FORMAT);

  static String sqlToDisplayDatetime(String sqlDatetime) {
    DateTime datetime = DateTime.parse(sqlDatetime);
    return displayDatetimeFmt.format(datetime);
  }

  static String sqlToDisplayDatetime2(String sqlDatetime) {
    DateTime datetime = DateTime.parse(sqlDatetime);
    return displayDatetimeFmt2.format(datetime);
  }
}
