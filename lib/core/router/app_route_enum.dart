enum AppRouteEnum {
  welcomePage,
  homePage,
  generalPage,
  photoViewPage
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.welcomePage:
        return "/welcome_page";

      case AppRouteEnum.homePage:
        return "/home_page";

      case AppRouteEnum.generalPage:
        return "/general_page";

      case AppRouteEnum.photoViewPage:
        return "/photo_view_page";
      }
  }
}