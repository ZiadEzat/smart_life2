// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:smart_life/model/face_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';

// class FaceProvider with ChangeNotifier {
//   final List<Face> _faces = [];
//   final SupabaseClient _client = Supabase.instance.client;
//   String ipAddress;

//   FaceProvider({required this.ipAddress}) {
//     _fetchFaces();
//     _listenToFaces();
//   }

//   List<Face> get faces => _faces;

//   Future<void> _fetchFaces() async {
//     final response = await _client.from('faces').select().execute();
//     if (response.error == null) {
//       _faces.clear();
//       for (var face in response.data) {
//         _faces.add(Face.fromMap(face));
//       }
//       notifyListeners();
//       _checkAccess();
//     } else {
//       print('Error fetching faces: ${response.error!.message}');
//     }
//   }

//   void _listenToFaces() {
//     _client.from('faces').on(SupabaseEventTypes.all, (payload) {
//       _fetchFaces();
//     }).subscribe();
//   }

//   void _checkAccess() {
//     for (var face in _faces) {
//       if (face.access) {
//         print(face.access);
//         _sendAccessGrantedRequest();
//         break;
//       }
//     }
//   }

//   Future<void> _sendAccessGrantedRequest() async {
//     final urlA = 'http://$ipAddress/?cmd=z';
//     final urlB = 'http://$ipAddress/?cmd=x';
//     print("sending");

//     try {
//       final responseA = await http.get(Uri.parse(urlA));
//       if (responseA.statusCode == 200) {
//         print('Access granted command sent successfully');
//         Timer(const Duration(seconds: 3), () async {
//           try {
//             final responseB = await http.get(Uri.parse(urlB));
//             if (responseB.statusCode == 200) {
//               print('Command b sent successfully after 10 seconds');
//             } else {
//               print('Failed to send command b');
//             }
//           } catch (e) {
//             print('Error sending command b: $e');
//           }
//         });
//       } else {
//         print('Failed to send access granted command');
//       }
//     } catch (e) {
//       print('Error sending access granted command: $e');
//     }
//   }
// }
