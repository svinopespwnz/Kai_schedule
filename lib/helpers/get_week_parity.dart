bool isEven()  {
  var d0 = DateTime.now().millisecondsSinceEpoch;
  var d = DateTime(DateTime.now().year, 1, 1);
  var d1 = d.millisecondsSinceEpoch;
  var re = (((d0 - d1) / 8.64e7) + (6)).floor();
  return ((re / 7).floor() % 2 == 0) ? true : false;
}