///Difference between Date
int daysBetween({required DateTime? apiDate, required DateTime? now}) {
  apiDate = DateTime(apiDate!.year, apiDate.month, apiDate.day);
  now = DateTime(now!.year, now.month, now.day);
  return (apiDate.difference(now).inHours / 24).round();
}
