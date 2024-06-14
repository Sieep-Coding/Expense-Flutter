import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkModeEnabled = false;
  double fontSize = 16.0;
  String selectedOption = 'Option 1';
  int sliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  darkModeEnabled = value;
                  // Apply dark mode settings here
                });
              },
            ),
            const SizedBox(height: 20),
            Text('Font Size: ${fontSize.toStringAsFixed(1)}'),
            Slider(
              min: 10.0,
              max: 30.0,
              divisions: 4,
              value: fontSize,
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                  // Apply font size settings here
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  // Handle selected option change
                });
              },
              items: ['Option 1', 'Option 2', 'Option 3']
                  .map((String option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
                  .toList(),
              decoration: const InputDecoration(
                labelText: 'Select an option',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save settings or perform additional actions
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
