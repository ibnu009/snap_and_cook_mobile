extension IntExtension on int {
  String toTimerCountDown(){
    if (this < 10){
      return "00:0$this";
    }
    return "00:$this";
  }
}
