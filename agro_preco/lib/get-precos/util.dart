class Util {
  static Map<String, String> meses = {
    'Janeiro': '01',
    'Fevereiro': '02',
    'Março': '03',
    'Abril': '04',
    'Maio': '05',
    'Junho': '06',
    'Julho': '07',
    'Agosto': '08',
    'Setembro': '09',
    'Outubro': '10',
    'Novembro': '11',
    'Dezembro': '12',
  };

  static String transformDate(labelDate) {
    String data = labelDate.replaceAll(' de ', '/');

    List<String> parts = data.split('/');

    return data.replaceFirst(parts[1], getMes(parts[1]));
  }

  static String getMes(String labelMes) {
    return meses[labelMes];
  }
}
