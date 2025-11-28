import 'package:google_maps_flutter/google_maps_flutter.dart';

enum FilterType { Upcoming, Recent, List }

class Earthquake {
  final double latitude;
  final double longitude;
  final String title;
  final String magnitude;
  final String depth;
  final String date;
  final String details;
  final FilterType type;

  Earthquake({
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.magnitude,
    required this.depth,
    required this.date,
    required this.details,
    required this.type,
  });

  factory Earthquake.fromJson(Map<String, dynamic> json) {
    return Earthquake(
      latitude: (json["latitude"] ?? 0.0).toDouble(),
      longitude: (json["longitude"] ?? 0.0).toDouble(),
      title: json["place"] ?? "Unknown Place",
      magnitude: (json["mag"] ?? 0.0).toString(),
      depth: (json["depth"] ?? 0.0).toString(),
      date: json["quake_time"]?.toString() ?? "",
      details: json["url"] ?? "",
      type: FilterType.Upcoming, // API অনুযায়ী adjust করতে পারেন
    );
  }

  LatLng get position => LatLng(latitude, longitude);
}
