
class Translations{
  static final languages = <String>[
    'English',
    'French',
    'Japness',
  ];

  static String getLanguageCode(String language){
    switch(language){
      case 'English':
        return 'en';
      case 'French':
        return 'fr';
      case 'Japness':
        return 'jp';
      default:
        return 'fr';
    }
  }
}