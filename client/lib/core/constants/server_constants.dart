import 'package:flutter/foundation.dart';

class ServerConstants {
  static const String _localIP = '172.27.64.119';

  static String serverURL = kReleaseMode
      ? 'https://music-app-delta-wheat.vercel.app'
      : 'http://$_localIP:3000';
}
