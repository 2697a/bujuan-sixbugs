import 'dart:io';

import 'package:bujuan/main/routes.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'constant/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  await SpUtil.getInstance();
  await FlutterDownloader.initialize();
  Constants.dark = SpUtil.getBool('dark',defValue: false);
  runApp(routes.buildPage("main", null));
}

//Future<HttpServer> _startServer({address = "localhost", int port = 3000}) {
//  return HttpServer.bind(address, port, shared: true).then((server) {
//    print("start listen at: http://$address:$port");
//    server.listen((request) {
//      _handleRequest(request);
//    });
//    return server;
//  });
//}
//
//void _handleRequest(HttpRequest request) async {
//  final answer = await cloudMusicApi(request.uri.path,
//          parameter: request.uri.queryParameters, cookie: request.cookies)
//      .catchError((e, s) async {
//    print(e.toString());
//    return Answer();
//  });
//
//  request.response.statusCode = answer.status;
//  request.response.cookies.addAll(answer.cookie);
//  request.response.write(json.encode(answer.body));
//  request.response.close();
//
//  print("request[${answer.status}] : ${request.uri}");
//}
