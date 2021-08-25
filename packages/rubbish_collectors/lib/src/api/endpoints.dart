class Endpoints {
  static String baseUrl() => 'http://217.219.165.22:5005';
  static String authSendCodePath() => '/Auth/SendCode';
  static String authLoginPath() => '/Auth/Login';
  static String authRefreshPath() => '/Auth/Refresh';
  static String userGetInfoPath() => '/User';
  static String userPatchInfoPath() => '/User';
  static String provincePath() => '/Province';
  static String citiesPath() => '/City';
  static String pickUpCreateSpecial() => '/PickUp/CreateSpecial';
  static String buildingCreatePath() => '/Building';
  static String todayBuildingsPath() => '/Driver/Building/TodayBuildings';
  static String todaySpacialBuildingsPath() => '/Driver/PickUp/Special';
  static String acceptBuildingPath() => '/Driver/PickUp/Accept';
  static String acceptSpacialBuildingPath() => '/Driver/PickUp/AcceptSpecial';
  static String completeRequestPath() => '/Driver/PickUp/AcceptSpecial';
}
