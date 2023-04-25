class AppConfig {
  String _nameApp = '';
  String _apiHost = '';
  // String _hereApiHost = '';
  // String _searchHereApi = '';

  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();

  static AppConfig get instance => _instance;
  String get nameApp => _nameApp;
  String get apiHost => _apiHost;
  // String get hereApiHost => _hereApiHost;
  // String get searchHereApi => _searchHereApi;

  void init({
    required String nameApp,
    required String apiHost,
    // required String hereApiHost,
    // required String searchHereApi,
  }) {
    _nameApp = nameApp;
    _apiHost = apiHost;
    // _hereApiHost = hereApiHost;
    // _searchHereApi = searchHereApi;
  }
}
