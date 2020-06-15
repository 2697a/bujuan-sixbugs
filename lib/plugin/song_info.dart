//class SongInfo {
//  String songId;
//  String songName;
//  String artist;
//  String songCover;
//  String songUrl;
//  bool isLike;
//
//  SongInfo({this.songId, this.songUrl, this.songName, this.artist, this.songCover,this.isLike});
//
//  SongInfo.fromJson(Map<String, dynamic> json) {
//    songId = json['songId'];
//    songName = json['songName'];
//    artist = json['artist'];
//    songCover = json['songCover'] ?? '';
//    songUrl = json['songUrl'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['songId'] = this.songId;
//    data['songName'] = this.songName;
//    data['artist'] = this.artist ?? '';
//    data['songCover'] = this.songCover ?? '';
//    data['songUrl'] = this.songUrl;
//    return data;
//  }
//}
