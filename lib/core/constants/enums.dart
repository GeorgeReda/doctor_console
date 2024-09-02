enum Payment {
  renewal,
  books,
}

enum Months {
  month1,
  month2,
  month3,
  month4,
  month5,
  month6,
  month7,
  month8,
  month9,
  month10,
  month11,
  month12
}

extension ThirdMonthsExt on Months {
  String get thirdDesc {
    switch (this) {
      case Months.month1:
        return 'الشهر الأول';
      case Months.month2:
        return 'الشهر الثاني';
      case Months.month3:
        return 'الشهر الثالث';
      case Months.month4:
        return 'الشهر الرابع';
      case Months.month5:
        return 'الشهر الخامس';
      case Months.month6:
        return 'الشهر السادس';
      case Months.month7:
        return 'الشهر السابع';
      case Months.month8:
        return 'الشهر الثامن';
      case Months.month9:
        return 'الشهر التاسع';
      case Months.month10:
        return 'الشهر العاشر';
      case Months.month11:
        return 'الشهر الحادي عشر';
      case Months.month12:
        return 'الشهر الثاني عشر';
      default:
        return '';
    }
  }
}

extension SecondMonthsExt on Months {
  String get secondDesc {
    switch (this) {
      case Months.month1:
        return 'الشهر الأول (الترم الاول)';
      case Months.month2:
        return 'الشهر الثاني (الترم الاول)';
      case Months.month3:
        return 'الشهر الثالث (الترم الاول)';
      case Months.month4:
        return 'الشهر الرابع (الترم الاول)';
      case Months.month5:
        return 'الشهر الخامس (الترم الاول)';
      case Months.month6:
        return 'الشهر الأول (الترم الثاني)';
      case Months.month7:
        return 'الشهر الثاني (الترم الثاني)';
      case Months.month8:
        return 'الشهر الثالث (الترم الثاني)';
      case Months.month9:
        return 'الشهر الرابع (الترم الثاني)';
      case Months.month10:
        return 'الشهر الخامس (الترم الثاني)';
      default:
        return '';
    }
  }
}

enum Year {
  none,
  second,
  third,
}

extension YearExt on Year {
  String get desc {
    switch (this) {
      case Year.second:
        return 'الصف الثاني الثانوي';
      case Year.third:
        return 'الصف الثالث الثانوي';
      default:
        return '';
    }
  }
}

enum Books { first, second, third, fourth }

extension BooksExt on Books {
  String get desc {
    switch (this) {
      case Books.first:
        return 'مذكرة الفصل الأول';
      case Books.second:
        return 'مذكرة الفصل الثاني و الثالث';
      case Books.third:
        return 'مذكرة الفصل الرابع و الحديثة';
      case Books.fourth:
        return 'مذكرة المراجعة النهائية';
      default:
        return '';
    }
  }
}
