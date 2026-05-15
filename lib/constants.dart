import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amsl_app/flavors.dart';

class ApiConstants {
  static String baseUrl = F.apiUrl;
  static const apiPath = 'api/v0';
  static bool https = F.https;
  static const List<String> scopes = ['openid', 'profile'];

  static Uri Function(
    String authority, [
    String unencodedPath,
    Map<String, dynamic>? queryParameters,
  ])
  get scheme => https ? Uri.https : Uri.http;

  static String get schemeString => https ? "https" : "http";

  static String get wsSchemeString => https ? "wss" : "ws";

  static String redirectUrl = F.redirectUrl;

  static String get loginUrl => '$schemeString://$baseUrl/login/token';
}

//BottomBar
double getBottomBarHeight(BuildContext context) {
  return Platform.isAndroid
      ? kBottomNavigationBarHeight
      : MediaQuery.of(context).padding.bottom;
}

double getBottomBarPadding(BuildContext context) {
  return getBottomBarHeight(context) + 32;
}

//DateFormat
DateFormat kNewDateFormat = DateFormat('dd.MM.yyyy');

DateFormat kOldDateFormat = DateFormat('yyyy-MM-dd');

DateFormat kNewDateTimeFormat = DateFormat('dd.MM.yyyy HH:mm');

DateFormat kOldTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
