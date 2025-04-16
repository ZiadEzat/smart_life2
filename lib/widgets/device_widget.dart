import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DeviceWidget extends StatelessWidget {
  final String deviceName;
  final String ipAddress;
  final String param1;
  final String param2;
  final bool isOn;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  // Create a single instance of Dio
  // final Dio dio = Dio();

  DeviceWidget({
    Key? key,
    required this.deviceName,
    required this.ipAddress,
    required this.param1,
    required this.param2,
    required this.isOn,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  // Future<void> sendCommand(String command) async {
  //   final url = 'http://$ipAddress$command';
  //   print('Sending command: $command to $ipAddress');
  //   try {
  //     final response = await dio.get(url);
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.data}');
  //     if (response.statusCode == 200) {
  //       print('Command sent successfully');
  //     } else {
  //       print(
  //           'Failed to send command with status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error sending command: $e');
  //   }
  // }

  Future<void> sendCommand(String command) async {
    final url = 'http://$ipAddress$command';
    print('Sending command: $command to $ipAddress');
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        print('Command sent successfully');
      } else {
        print(
            'Failed to send command with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending command: $e');
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850], // Dark background color
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                deviceName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text color
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ipAddress,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70, // Light grey text color
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Power',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white, // White text color
                ),
              ),
              Switch(
                value: isOn,
                onChanged: (value) {
                  onToggle(value);
                  sendCommand(value ? param1 : param2);
                },
                activeColor: Colors.green,
                inactiveThumbColor: Colors.red,
                inactiveTrackColor: Colors.red.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
