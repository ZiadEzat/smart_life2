import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_life/model/ip_model.dart';
import 'package:smart_life/model/user_model.dart';
import 'package:smart_life/views/add_device.dart';
// import 'package:smart_life/views/faceid.dart';
import 'package:smart_life/widgets/background_linear.dart';
import 'package:smart_life/widgets/device_widget.dart';
import 'package:smart_life/views/car_count.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  List<Map<String, dynamic>> devices = [];

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> devices = [
    {
      'name': 'Default Device',
      'ip': '192.168.1.1',
      'category': 'Lightning',
      'param1': '?cmd=1',
      'param2': '?cmd=0',
      'isConnected': true,
      'isOn': false,
    },
  ];

  void _loadDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? devicesString = prefs.getString('devices');
    if (devicesString != null) {
      setState(() {
        devices = List<Map<String, dynamic>>.from(json.decode(devicesString));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _saveDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('devices', json.encode(devices));
  }

  void _addDevice(
      String name, String ip, String category, String param1, String param2) {
    setState(() {
      devices.add({
        'name': name,
        'ip': ip,
        'category': category,
        'param1': param1,
        'param2': param2,
        'isConnected': true,
        'isOn': false,
      });
      _saveDevices();
    });
  }

  void _deleteDevice(int index) {
    setState(() {
      devices.removeAt(index);
    });
  }

  void _showGarageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Garage',
            style: TextStyle(color: Colors.white),
          ),
          content: Text("data"), // Display the CarCount widget in the dialog
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IpModel(),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundScreen(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    color: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(Icons.miscellaneous_services_sharp),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.watch<UserModel>().name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              'Welcome back home',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                color: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.directions_car,
                                  color: Colors.white60),
                              onPressed: _showGarageDialog,
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.face, color: Colors.white60),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Text('data')),
                                );
                              },
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddDeviceDialog(
                                        onAddDevice: _addDevice,
                                      );
                                    },
                                  );
                                },
                                label: const Text(
                                  'Add Device',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(18.0),
                      itemCount: devices.length,
                      itemBuilder: (context, index) {
                        final device = devices[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18.0),
                          child: DeviceWidget(
                            deviceName: device['name'],
                            ipAddress: device['ip'],
                            param1: device['param1'],
                            param2: device['param2'],
                            isOn: device['isOn'],
                            onToggle: (bool value) {
                              setState(() {
                                device['isOn'] = value;
                              });
                            },
                            onDelete: () => _deleteDevice(index),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
