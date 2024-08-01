import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:overlay_support/overlay_support.dart';

import '../widgets/loginAndLoginLater.dart';


class ConnectivityService {
  void startMonitoring(BuildContext context) {
    InternetConnection().onStatusChange.listen((event) {
      bool connected= event ==InternetStatus.connected;
      Color backgroundColor = connected ? Colors.green : Colors.red;
      LoginandLoginLaterpage.showInternet(context, 'My internet ',isDismissible: connected);
      showSimpleNotification(Text(  connected ? "connected to internet ": "  please connect to the Internet "),background: backgroundColor);
    });
  }
}
