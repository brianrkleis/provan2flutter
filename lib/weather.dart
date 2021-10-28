class Weather {
  Weather({
    required this.country,
    required this.date,
    required this.text
});

  final String country;
  final String date;
  final String text;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
      country: json["country"],
      date: json["date"],
      text: json["text"]
  );

}