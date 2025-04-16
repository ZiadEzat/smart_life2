import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_life/model/ip_model.dart';
import 'package:smart_life/model/user_model.dart';
import 'package:smart_life/views/add_device.dart';
import 'package:smart_life/views/login_screen.dart';
import 'package:smart_life/widgets/background_linear.dart';
import 'package:smart_life/widgets/device_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
void _deleteDevice(int index) {
    setState(() {
      devices.removeAt(index);
    });
  }

  void loadFromSupabase() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user is logged in')),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('device')
          .select('name, ip_address')
          .eq('user_id', user.id);

      if (response != null) {
        setState(() {
          devices = List<Map<String, dynamic>>.from(response).map((device) {
            return {
              'name': device['name'],
              'ip': device['ip_address'],
            };
          }).toList();
        });
        print('Devices loaded successfully: $devices');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No devices found for this user.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  void signOut(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $error')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadFromSupabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundScreen(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          ElevatedButton(
                            onPressed: () => signOut(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
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
                          deviceName: device['name'] ?? 'Unknown Device',
                          ipAddress: device['ip'] ?? '0.0.0.0',
                          param1: device['param1'] ?? '',
                          param2: device['param2'] ?? '',
                          isOn: device['isOn'] ?? false,
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
    );
  }
}
