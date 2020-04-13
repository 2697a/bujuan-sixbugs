// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:bujuan/entity/testsong_entity.dart';
import 'package:bujuan/generated/json/testsong_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case TestsongEntity:
			return testsongEntityFromJson(data as TestsongEntity, json) as T;			case TestsongList:
			return testsongListFromJson(data as TestsongList, json) as T;    }
    return data as T;
  }  static _getToJson<T>(Type type, data) {
		switch (type) {			case TestsongEntity:
			return testsongEntityToJson(data as TestsongEntity);			case TestsongList:
			return testsongListToJson(data as TestsongList);    }
    return data as T;
  }  static T fromJsonAsT<T>(json) {
    switch (T.toString()) {			case 'TestsongEntity':
			return TestsongEntity().fromJson(json) as T;			case 'TestsongList':
			return TestsongList().fromJson(json) as T;    }
    return null;
  }}