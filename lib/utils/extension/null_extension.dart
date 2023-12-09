extension NullIntExtension on int? {

}

extension NullBooleanExtension on bool? {
  bool toDefault(){
    return this ?? false;
  }
}