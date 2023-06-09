import 'package:get/get.dart';

class SchemeJumpState {
  final _schemeUri = ''.obs;
  set schemeUri(String value) => _schemeUri.value = value;
  String get schemeUri => _schemeUri.value;

  final _schemeUriHost = ''.obs;
  set schemeUriHost(String value) => _schemeUriHost.value = value;
  String get schemeUriHost => _schemeUriHost.value;

  final _schemeUriQuery = ''.obs;
  set schemeUriQuery(String value) => _schemeUriQuery.value = value;
  String get schemeUriQuery => _schemeUriQuery.value;
}
