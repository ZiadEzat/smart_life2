// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class CarCount extends StatefulWidget {
//   @override
//   _CarCountState createState() => _CarCountState();
// }

// class _CarCountState extends State<CarCount> {
//   String? carCount;
//   RealtimeSubscription? carCountSubscription;

//   @override
//   void initState() {
//     super.initState();
//     fetchCarCount();
//     subscribeToCarCountUpdates();
//   }

//   void fetchCarCount() async {
//     final response = await Supabase.instance.client
//         .from('park')
//         .select('car_count')
//         .execute();
//     if (response.error == null) {
//       setState(() {
//         carCount = response.data[0]['car_count'].toString();
//       });
//     }
//   }

//   void subscribeToCarCountUpdates() {
//     carCountSubscription = Supabase.instance.client
//         .from('park')
//         .on(SupabaseEventTypes.update, (payload) {
//       fetchCarCount();
//     }).subscribe();
//   }

//   @override
//   void dispose() {
//     if (carCountSubscription != null) {
//       Supabase.instance.client.removeSubscription(carCountSubscription!);
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.grey[850],
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: carCount == null
//             ? CircularProgressIndicator()
//             : Text(
//                 'Car Count: $carCount',
//                 style: TextStyle(fontSize: 27, color: Colors.white),
//               ),
//       ),
//     );
//   }
// }
