enum Payment {
  renewal,
  books,
}

enum Months { first, second, third, fourth, fifth, sixth, seventh }

extension ThirdMonthsExt on Months {
  String get thirdDesc {
    switch (this) {
      case Months.first:
        return 'الفصل الأول';
      case Months.second:
        return 'الفصل الثاني';
      case Months.third:
        return 'الفصل الثالث';
      case Months.fourth:
        return 'الفصل الرابع و الخامس (الجديد)';
      // case Months.fifth:
      //   return 'الفصل السادس و السابع و الثامن (الجديد)';
      default:
        return '';
    }
  }
}

extension SecondMonthsExt on Months {
  String get secondDesc {
    switch (this) {
      case Months.first:
        return 'الشهر الأول (الترم الثاني)';

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

enum Books { first, second, third }

extension BooksExt on Books {
  String get desc {
    switch (this) {
      case Books.first:
        return 'مذكرة الفصل الأول';
      case Books.second:
        return 'مذكرة الفصلين الثاني و الثالث';
      case Books.third:
        return 'مذكرة الفصلين الرابع و الحديثة';
      default:
        return '';
    }
  }
}
