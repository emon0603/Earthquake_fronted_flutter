import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

class EarthquakePage extends StatefulWidget {
  @override
  State<EarthquakePage> createState() => _EarthquakePageState();
}

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
      type: FilterType.Upcoming, // আপনি চাইলে API অনুযায়ী adjust করতে পারেন
    );
  }

  LatLng get position => LatLng(latitude, longitude);
}

class _EarthquakePageState extends State<EarthquakePage> {
  GoogleMapController? mapController;
  FilterType selectedFilter = FilterType.Upcoming;
  List<Earthquake> allLocations = [];
  Earthquake? selectedLocation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEarthquakes();
  }

  Future<void> fetchEarthquakes() async {
    const String url = "http://192.168.0.106:8000/api/earthquakes";

    try {
      final response = await Dio().get(url);
      final List data = response.data['data'];

      // Debug print
      print("Fetched ${data.length} earthquakes from API");

      setState(() {
        allLocations = data.map((e) => Earthquake.fromJson(e)).toList();
        selectedLocation =
        allLocations.isNotEmpty ? allLocations.first : null;
        isLoading = false;
      });
    } catch (e) {
      print("Failed to fetch data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Earthquake> get quakeLocations {
    if (selectedFilter == FilterType.List) return [];
    return allLocations.where((e) => e.type == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedLocation?.position ?? LatLng(8.25, 116.0),
              zoom: 6.5,
            ),
            onMapCreated: (controller) => mapController = controller,
            markers: quakeLocations
                .map((quake) => Marker(
              markerId: MarkerId(quake.title),
              position: quake.position,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              onTap: () {
                setState(() {
                  selectedLocation = quake;
                });
              },
            ))
                .toSet(),
          ),

          // Filter Buttons
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _filterButton("Upcoming",
                    selectedFilter == FilterType.Upcoming, () {
                      setState(() {
                        selectedFilter = FilterType.Upcoming;
                        selectedLocation = quakeLocations.isNotEmpty
                            ? quakeLocations.first
                            : null;
                      });
                    }),
                SizedBox(width: 8),
                _filterButton(
                    "Recent", selectedFilter == FilterType.Recent, () {
                  setState(() {
                    selectedFilter = FilterType.Recent;
                    selectedLocation = quakeLocations.isNotEmpty
                        ? quakeLocations.first
                        : null;
                  });
                }),
                SizedBox(width: 8),
                _filterButton("List", selectedFilter == FilterType.List, () {
                  setState(() {
                    selectedFilter = FilterType.List;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => EarthquakeListPage(
                          locations: allLocations,
                        )),
                  ).then((_) {
                    setState(() {
                      selectedFilter = FilterType.Upcoming;
                      selectedLocation = quakeLocations.isNotEmpty
                          ? quakeLocations.first
                          : null;
                    });
                  });
                }),
              ],
            ),
          ),

          // Bottom Card
          if (selectedLocation != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _bottomInfoCard(selectedLocation!),
            ),
        ],
      ),
    );
  }

  Widget _filterButton(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.white70,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            if (active)
              BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3)),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
              color: active ? Colors.black : Colors.grey[700],
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _bottomInfoCard(Earthquake quake) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, offset: Offset(0, -3)),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _infoBox(Icons.calendar_today, quake.date),
              _infoBox(Icons.analytics, quake.magnitude),
              _infoBox(Icons.arrow_downward, quake.depth),
            ],
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(quake.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(quake.details, style: TextStyle(fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoBox(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Colors.blue),
        SizedBox(height: 20),
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

/// Earthquake List Page
class EarthquakeListPage extends StatelessWidget {
  final List<Earthquake> locations;

  const EarthquakeListPage({required this.locations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Earthquake List")),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final loc = locations[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              title: Text(loc.title),
              subtitle: Text("Magnitude: ${loc.magnitude} | Depth: ${loc.depth}"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Open URL: ${loc.details}");
              },
            ),
          );
        },
      ),
    );
  }
}
