//import 'package:flutter/material.dart';
//
//import 'package:flutterstarrysky/flutter_starry_sky.dart';
//import 'package:flutterstarrysky/song_info.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  List<SongInfo> infos = [];
//  PlayStateType stateType = PlayStateType.STOP;
//
//  @override
//  void initState() {
//    super.initState();
//    getSongInfos();
//  }
//
//  getSongInfos() async {
//    await FlutterStarrySky.init();
//    SongInfo songInfo = SongInfo();
//    songInfo.songId = '001';
//    songInfo.songName = '稻香';
//    songInfo.artist = '周杰伦';
//    songInfo.songUrl = 'http://music.163.com/song/media/outer/url?id=33789165.mp3';
//    SongInfo songInfo1 = SongInfo();
//    songInfo1.songId = '002';
//    songInfo1.songName = '冬眠';
//    songInfo1.artist = '思南';
//    songInfo1.songUrl = 'http://music.163.com/song/media/outer/url?id=1398663411.mp3';
//    SongInfo songInfo2 = SongInfo();
//    songInfo2.songId = '003';
//    songInfo2.songName = '逍遥叹';
//    songInfo2.artist = '胡歌';
//    songInfo2.songUrl = 'http://music.163.com/song/media/outer/url?id=4875306.mp3';
//    setState(() {
//      infos
//        ..clear()
//        ..add(songInfo)
//        ..add(songInfo1)..add(songInfo2);
//    });
//    await FlutterStarrySky.setPlayList(infos);
//  }
//
//  @override
//  void dispose() {
//    FlutterStarrySky.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Plugin example app'),
//        ),
//        body: Column(
//          children: <Widget>[
//            Expanded(
//              child: ListView.builder(
//                shrinkWrap: true,
//                itemBuilder: (context, index) {
//                  return ListTile(
//                    title: Text('${infos[index].songName}'),
//                    subtitle: Text('${infos[index].artist}'),
//                    onTap: () async {
//                      int state = await FlutterStarrySky.playSongById(infos[index].songId);
//                      if (state == 1)
//                        setState(() {
//                          stateType = PlayStateType.START;
//                        });
//                    },
//                  );
//                },
//                itemCount: infos.length,
//              ),
//              flex: 2,
//            ),
//            Expanded(
//              child: Center(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    IconButton(
//                        icon: Icon(Icons.skip_previous),
//                        onPressed: () async {
//                          await FlutterStarrySky.previous();
//                        }),
//                    IconButton(
//                        icon: Icon(stateType == PlayStateType.STOP || stateType == PlayStateType.PAUSE ? Icons.play_arrow : Icons.pause),
//                        onPressed: () async {
//                          if (stateType == PlayStateType.STOP) {
//                            print('没有播放任何歌曲');
//                          } else {
//                            if (stateType == PlayStateType.PAUSE) {
//                              int restore = await FlutterStarrySky.restore();
//                              if (restore == 1)
//                                setState(() {
//                                  stateType = PlayStateType.START;
//                                });
//                            } else {
//                              int pause = await FlutterStarrySky.pause();
//                              if (pause == 1)
//                                setState(() {
//                                  stateType = PlayStateType.PAUSE;
//                                });
//                            }
//                          }
//                        }),
//                    IconButton(
//                        icon: Icon(Icons.skip_next),
//                        onPressed: () async {
//                          await FlutterStarrySky.next();
//                        }),
//                  ],
//                ),
//              ),
//              flex: 1,
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
