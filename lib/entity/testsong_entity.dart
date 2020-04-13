import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/generated/json/base/json_filed.dart';

class TestsongEntity with JsonConvert<TestsongEntity> {
	@JSONField(name: "list")
	List<TestsongList> xList;
}

class TestsongList with JsonConvert<TestsongList> {
	String id;
	String name;
	String picUrl;
	String singer;
}
