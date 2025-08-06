import 'package:EasyAptis/features/general_pages/presentation/pages/general_page.dart';
import 'package:EasyAptis/features/home/presentation/pages/home_page.dart';
import 'package:EasyAptis/features/welcome/presentation/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      case '/welcome_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => WelcomePage(),
        );
      case '/home_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => HomePage(),
        );
      case '/general_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => GeneralPage(),
        );

      // Ny Times Article Details page
      // case '/article_details_page':
      //   return CupertinoPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (_) {
      //       assert(
      //           settings.arguments != null, "nyTimesArticleModel is required");
      //       return ArticleDetailsPage(
      //         model: settings.arguments as ArticleModel,
      //       );
      //     },
      //   );

      // // Web view page
      // case '/web_view_page':
      //   return CupertinoPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (_) => WebViewPage(
      //       link: settings.arguments as String,
      //     ),
      //   );

      // // Photo view page
      // case '/photo_view_page':
      //   return CupertinoPageRoute(
      //     settings: RouteSettings(name: settings.name),
      //     builder: (_) {
      //       Map<String, dynamic>? args =
      //           settings.arguments as Map<String, dynamic>?;
      //       assert(args != null, "You should pass 'path' and 'fromNet'");
      //       return PhotoViewPage(
      //         path: args!['path'],
      //         fromNet: args['fromNet'],
      //       );
      //     },
      //   );

      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
