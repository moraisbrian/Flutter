import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseServerCredentials {
  static const _ApplicationId = '';
  static const _ServerUrl = '';
  static const _clientKey = '';

  static Future<void> initialize() async {
    await Parse().initialize(
      _ApplicationId,
      _ServerUrl,
      clientKey: _clientKey,
      autoSendSessionId: true,
      debug: true,
    );
  }
}
