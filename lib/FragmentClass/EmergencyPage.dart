import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyPage extends StatefulWidget {
  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                "One tap, Instant Resure",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 5),

              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(text: "Click the "),
                    TextSpan(text: "help button", style: TextStyle(color: Colors.red)),
                    TextSpan(text: " to call the help"),
                  ],
                ),
              ),

              SizedBox(height: 40),

              GestureDetector(
                onTapDown: (_) {
                  setState(() => _isPressed = true);
                },
                onTapUp: (_) {
                  setState(() => _isPressed = false);
                  print("HELP CLICKED!");
                  callNumber("999");
                },
                onTapCancel: () {
                  setState(() => _isPressed = false);
                },

                child: AnimatedScale(
                  scale: _isPressed ? 0.92 : 1.0,
                  duration: Duration(milliseconds: 120),
                  curve: Curves.easeOut,

                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 120),
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.4),
                          blurRadius: _isPressed ? 20 : 70,
                          spreadRadius: _isPressed ? 5 : 20,
                        ),
                      ],
                    ),

                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(color: Colors.white, width: 10),
                      ),
                      child: Center(
                        child: Text(
                          "HELP",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Text("Help is on the way!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 5),

              Text("ETA: 15 Minutes",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> callNumber(String number) async {
  final Uri url = Uri(scheme: 'tel', path: number);

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print("Could not launch $number");
  }
}

