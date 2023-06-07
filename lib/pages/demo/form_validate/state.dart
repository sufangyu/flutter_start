import 'package:get/get.dart';

class FormValidateState {
  final _radioListSelected = ''.obs;
  set radioListSelected(String value) => _radioListSelected.value = value;
  String get radioListSelected => _radioListSelected.value;

  final _checkboxListSelected = [].obs;
  set checkboxListSelected(value) => _checkboxListSelected.value = value;
  List get checkboxListSelected => _checkboxListSelected;

  // FormValidateState() {}
}
