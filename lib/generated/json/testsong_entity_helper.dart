import 'package:bujuan/entity/testsong_entity.dart';

testsongEntityFromJson(TestsongEntity data, Map<String, dynamic> json) {
	if (json['list'] != null) {
		data.xList = new List<TestsongList>();
		(json['list'] as List).forEach((v) {
			data.xList.add(new TestsongList().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> testsongEntityToJson(TestsongEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.xList != null) {
		data['list'] =  entity.xList.map((v) => v.toJson()).toList();
	}
	return data;
}

testsongListFromJson(TestsongList data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['picUrl'] != null) {
		data.picUrl = json['picUrl']?.toString();
	}
	if (json['singer'] != null) {
		data.singer = json['singer']?.toString();
	}
	return data;
}

Map<String, dynamic> testsongListToJson(TestsongList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['picUrl'] = entity.picUrl;
	data['singer'] = entity.singer;
	return data;
}