import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0F2C),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔹 TOP CARD
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF5EA6FF),
                    Color(0xFF4B71FF),
                  ],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Karangploso, Malang",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Today, 13 November 2022",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 30),

                  // Weather Icon + Temp
                  Icon(Icons.cloud, size: 90, color: Colors.white.withOpacity(0.9)),
                  const SizedBox(height: 10),

                  const Text(
                    "25°C",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Partly Cloudy",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                  const SizedBox(height: 30),

                  // Info Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      WeatherInfo(icon: Icons.air, label: "24 km/h", sub: "Wind"),
                      WeatherInfo(icon: Icons.water_drop, label: "60%", sub: "Humidity"),
                      WeatherInfo(icon: Icons.cloud_queue, label: "0%", sub: "Precip."),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🔹 HOURLY BAR
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  HourItem(time: "05:00"),
                  HourItem(time: "07:00"),
                  HourItem(time: "09:00", highlighted: true),
                  HourItem(time: "11:00"),
                  HourItem(time: "13:00"),
                ],
              ),
            ),

            // 🔹 BOTTOM NAVIGATION
            Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFF0D133A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  NavItem(icon: Icons.wb_sunny, label: "weather", active: true),
                  NavItem(icon: Icons.air_outlined, label: "air quality"),
                  NavItem(icon: Icons.public, label: "earthquake"),
                  NavItem(icon: Icons.more_horiz, label: "more"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sub;

  const WeatherInfo({super.key, required this.icon, required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        Text(
          sub,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class HourItem extends StatelessWidget {
  final String time;
  final bool highlighted;

  const HourItem({super.key, required this.time, this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: highlighted ? Colors.yellow.withOpacity(0.8) : Colors.white12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            color: highlighted ? Colors.black : Colors.white,
            fontWeight: highlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const NavItem({super.key, required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? Colors.white : Colors.white54),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(color: active ? Colors.white : Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
