import 'package:easyaptis/features/general_pages/general_page.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_p1/presentation/pages/listening_p1_page.dart';
import 'package:easyaptis/features/general_pages/listening_page/listening_page.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p1/presentation/pages/reading_p1_page.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p2vs3/presentation/pages/reading_p2vs3_page.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p4/presentation/pages/reading_p4_page.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_p5/presentation/pages/reading_p5_page.dart';
import 'package:easyaptis/features/general_pages/reading_pages/reading_page.dart';
import 'package:easyaptis/features/home/presentation/pages/home_page.dart';
import 'package:easyaptis/features/welcome/presentation/pages/welcome_page.dart';
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
      case '/reading_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => ReadingPage(),
        );
      case '/reading_p1_page':
        final args = settings.arguments as Map<String, dynamic>?;
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder:
              (_) => ReadingP1Page(page: args?['page'], limit: args?['limit']),
        );

      case '/reading_p2vs3_page':
        final args = settings.arguments as Map<String, dynamic>?;
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder:
              (_) =>
                  ReadingP2vs3Page(page: args?['page'], limit: args?['limit']),
        );

      case '/reading_p4_page':
        final args = settings.arguments as Map<String, dynamic>?;
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder:
              (_) => ReadingP4Page(page: args?['page'], limit: args?['limit']),
        );

      case '/reading_p5_page':
        final args = settings.arguments as Map<String, dynamic>?;
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder:
              (_) => ReadingP5Page(page: args?['page'], limit: args?['limit']),
        );

      case '/listening_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => ListeningPage(),
        );

      case '/listening_p1_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => ListeningP1Page(),
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
