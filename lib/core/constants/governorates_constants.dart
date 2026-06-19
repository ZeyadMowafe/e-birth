class GovernorateConstants {
  static const Map<int, String> governorates = {
    1: 'القاهرة',
    2: 'الجيزة',
    3: 'الإسكندرية',
    4: 'الدقهلية',
    5: 'البحر الأحمر',
    6: 'البحيرة',
    7: 'الفيوم',
    8: 'الغربية',
    9: 'الإسماعيلية',
    10: 'المنوفية',
    11: 'المنيا',
    12: 'القليوبية',
    13: 'الوادي الجديد',
    14: 'السويس',
    15: 'أسوان',
    16: 'أسيوط',
    17: 'بني سويف',
    18: 'بورسعيد',
    19: 'دمياط',
    20: 'الشرقية',
    21: 'جنوب سيناء',
    22: 'كفر الشيخ',
    23: 'مطروح',
    24: 'الأقصر',
    25: 'قنا',
    26: 'شمال سيناء',
    27: 'سوهاج',
  };

  static String getName(dynamic id) {
    if (id == null) return 'غير محدد';
    
    // If it's already a name (String and not a number)
    if (id is String && int.tryParse(id) == null && id.isNotEmpty && id != '0') {
      return id;
    }

    final intId = int.tryParse(id.toString()) ?? 0;
    return governorates[intId] ?? (id.toString() == '0' ? 'غير محدد' : id.toString());
  }
}
