enum Months { first, second, third, fourth }

extension MonthsExt on Months {
  String get desc {
    switch (this) {
      case Months.first:
        return 'الشهر الأول';
      case Months.second:
        return 'الشهر الثاني';
      case Months.third:
        return 'الشهر الثالث';
      case Months.fourth:
        return 'الشهر الرابع';
      default:
        return '';
    }
  }
}

enum Year { none, second, third }

extension YearExt on Year {
  String get desc {
    switch (this) {
      case Year.second:
        return 'الصف الثاني الثانوي';
      case Year.third:
        return 'الصف الثالث الثانوي';
      default:
        return 'غير محدد';
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
        return 'مذكرة الفصلين الثاني و الثالث';
      case Books.third:
        return 'مذكرة الفصل الرابع و الحديثة';
      case Books.fourth:
        return 'مذكرة المراجعة النهائية';
      default:
        return '';
    }
  }
}
