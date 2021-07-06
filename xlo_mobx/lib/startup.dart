import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/parse_server_credentials.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class Startup {
  static Future<void> _setupParseServer() async {
    await Parse().initialize(
      ParseServerCredentials.applicationId,
      ParseServerCredentials.serverUrl,
      clientKey: ParseServerCredentials.clientKey,
      autoSendSessionId: true,
      debug: true,
    );
  }

  static void _setupLocators() {
    GetIt.I.registerSingleton(PageStore());
  }

  static Future<void> initialize() async {
    await _setupParseServer();
    _setupLocators();
  }
}
