enum PaymentMethod { vodafoneCash, fawry }

enum Months { first, second, third }

extension MonthsExt on Months {
  String get desc {
    switch (this) {
      case Months.first:
        return 'الشهر الأول';
      case Months.second:
        return 'الشهر الثاني';
      case Months.third:
        return 'الشهر الثالث';
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
