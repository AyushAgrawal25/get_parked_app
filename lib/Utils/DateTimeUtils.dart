class DateTimeUtils {
  static String timeIn12HoursFormat(String utcTime) {
    String time = "";

    DateTime dateTime = DateTime.parse(utcTime).toLocal();
    time += hour24To12(dateTime.hour).toString() + ":";
    if (dateTime.minute > 9) {
      time += dateTime.minute.toString();
    } else {
      time += "0" + dateTime.minute.toString();
    }
    time += " " + getMeridan(dateTime.hour);
    return time;
  }

  static int hour24To12(int hour) {
    int hourIn12HourFormat;
    if (hour == 0) {
      hourIn12HourFormat = 12;
    } else if ((hour > 0) && (hour < 12)) {
      hourIn12HourFormat = hour;
    } else if (hour == 12) {
      hourIn12HourFormat = 12;
    } else if (hour > 12) {
      hourIn12HourFormat = hour % 12;
    }

    return hourIn12HourFormat;
  }

  static String getMeridan(int hour) {
    String meridan = "";
    if (hour == 0) {
      meridan += "am";
    } else if ((hour > 0) && (hour < 12)) {
      meridan += "am";
    } else if (hour == 12) {
      meridan += "pm";
    } else if (hour > 12) {
      meridan += "pm";
    }
    return meridan;
  }

  static String from24To12HoursFormat(int hour) {
    String hours = "";
    if (hour == 0) {
      hours += "12 am";
    } else if ((hour > 0) && (hour < 12)) {
      hours += "$hour am";
    } else if (hour == 12) {
      hours += "12 pm";
    } else if (hour > 12) {
      hours += "${hour % 12} pm";
    }
    return hours;
  }

  static String dateIn12MonthsFormat(String utcTime) {
    String date = "";
    DateTime dateTime = DateTime.parse(utcTime).toLocal();

    // Day
    date += dateTime.day.toString() + " ";

    // Month
    date += monthsList[dateTime.month - 1] + " ";

    // Year
    date += dateTime.year.toString();

    return date;
  }

  static List<String> monthsList = [
    "Jan",
    "Feb",
    "March",
    "April",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static String durationInHrAndMinFromatFromMins(int durationInMins) {
    String durationInHrAndMinFormat = "";
    int days = (durationInMins ~/ (24 * 60)).toInt();
    if (days > 0) {
      durationInHrAndMinFormat += days.toString() + " Days ";
    }

    int hours = ((durationInMins ~/ 60).toInt() % 24);
    if (hours > 0) {
      durationInHrAndMinFormat += hours.toString() + " Hrs ";
    }

    int mins = (durationInMins % (60));
    if (mins > 0) {
      durationInHrAndMinFormat += mins.toString() + " Mins";
    }

    return durationInHrAndMinFormat.trim();
  }

  static String timeForDisplayRelative(String utcTime) {
    DateTime timeOfEvent = DateTime.parse(utcTime).toLocal();
    DateTime currentTime = DateTime.now().toLocal();

    String formattedDate = formatDateForDateTimeParse(timeOfEvent);
    DateTime startingEventDay = DateTime.parse("$formattedDate 00:00:00");

    Duration diffInTime = currentTime.difference(timeOfEvent);
    Duration diffInDate = currentTime.difference(startingEventDay);

    String reqTime = "";
    if (diffInDate.inDays == 0) {
      if (diffInTime.inHours == 0) {
        if (diffInTime.inMinutes == 0) {
          if (diffInTime.inSeconds == 0) {
            reqTime = "Now";
          } else {
            if (diffInTime.inSeconds == 1) {
              reqTime = "${diffInTime.inSeconds} second ago";
            } else {
              reqTime = "${diffInTime.inSeconds} seconds ago";
            }
          }
        } else {
          if (diffInTime.inMinutes == 1) {
            reqTime = "${diffInTime.inMinutes} minute ago";
          } else {
            reqTime = "${diffInTime.inMinutes} minutes ago";
          }
        }
      } else {
        if (diffInTime.inHours == 1) {
          reqTime = "${diffInTime.inHours} hour ago";
        } else {
          reqTime = "${diffInTime.inHours} hours ago";
        }
      }
    }

    return reqTime;
  }

  static String dateForDisplayRelative(String utcTime) {
    DateTime timeOfEvent = DateTime.parse(utcTime).toLocal();
    String formattedDate = formatDateForDateTimeParse(timeOfEvent);
    DateTime startingEventDay = DateTime.parse("$formattedDate 00:00:00");
    DateTime currentTime = DateTime.now().toLocal();

    Duration diffInTime = currentTime.difference(startingEventDay);

    String reqDate = "";
    if (diffInTime.inDays == 0) {
      reqDate = "";
    } else if (diffInTime.inDays == 1) {
      reqDate = "Yesterday";
    } else if (diffInTime.inDays < 4) {
      reqDate = "${diffInTime.inDays} days ago";
    } else {
      reqDate =
          "${timeOfEvent.day} ${monthsList[timeOfEvent.month - 1]} ${timeOfEvent.year}";
    }

    return reqDate;
  }

  static String formatDateForDateTimeParse(DateTime dateTime) {
    int year = dateTime.year;
    int day = dateTime.day;
    int month = dateTime.month;

    String formattedDate = "";
    formattedDate += year.toString();
    formattedDate += "-";

    if (month < 10) {
      formattedDate += "0";
    }
    formattedDate += month.toString();
    formattedDate += "-";

    if (day < 10) {
      formattedDate += "0";
    }
    formattedDate += day.toString();
    return formattedDate;
  }
}
