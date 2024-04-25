import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profileModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Read the arguments
    final profileInfo =
        ModalRoute.of(context)!.settings.arguments as ProfileInfo;
    // set initial biometric state from the provided arguments
    bool _switchValue = profileInfo.biometric;
    return Scaffold(
      appBar: AppBar(
        // Back button to go back to login screen
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Home"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Circular Image
              CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage('assets/profile.png'),
              ),
              const SizedBox(
                height: 4,
              ),
              // Displaying name
              Text(
                profileInfo.name,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              // Displaying additional details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    detailsRow("Phone", Icons.phone, profileInfo.phone),
                    detailsRow("Email", Icons.email, profileInfo.email),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.fingerprint,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Biometric",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        Switch(
                          value: _switchValue,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            setState(() => {_switchValue = value});
                          },
                        )
                      ],
                    ),
                    detailsRow(
                        "Address", Icons.location_pin, profileInfo.address),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // Button to go to top tab naviagtion page
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  // Using named routes defined in main.dart
                  onPressed: () =>
                      Navigator.pushNamed(context, '/top_navigation'),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Top Tab Navigation",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              // Button to go to bottom tab naviagtion page
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  // Using named routes defined in main.dart
                  onPressed: () =>
                      Navigator.pushNamed(context, '/bottom_navigation'),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Botton Tab Navigation",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // creating logout button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                child: ElevatedButton(
                  // Using named routes defined in main.dart
                  onPressed: () async {
                    // setting isLoggedIn to false in sharedPreferences
                    final sharedPrefs = await SharedPreferences.getInstance();
                    sharedPrefs.setBool('isLoggedIn', false);
                    Navigator.pushNamed(context, '/');
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // separate function to call the simailar details row
  Row detailsRow(String text, IconData icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        // using flexible to avoid overflow
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
