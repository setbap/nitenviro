class Endpoints {
  static String baseUrl() => 'http://217.219.165.22:5005';
  static String authSendCodePath() => '/Auth/SendCode';
  static String authLoginPath() => '/Auth/Login';
  static String authRefreshPath() => '/Auth/Refresh';
  static String userGetInfoPath() => '/User';
  static String userPatchInfoPath() => '/User';
  static String provincePath() => '/Province';
  static String citiesPath() => '/City';
  static String buildingCreatePath() => '/Building';
  static String todayBuildingsPath() => '/Building/TodayBuildings';
}
