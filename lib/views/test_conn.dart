import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_life/model/ip_model.dart';
import 'package:smart_life/model/user_model.dart';
import 'package:smart_life/views/homepage.dart';
import 'package:smart_life/widgets/background_linear.dart';

class testconn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // labeltext for user input
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.transparent, // Ensure the scaffold background is transparent
      ),
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
            children: [
              BackgroundScreen(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Enter IP Address'),
                    TextField(
                      controller: TextEditingController(),
                      onSubmitted: (ip) {
                        context.read<IpModel>().fetchData(ip);
                        // context.read<UserModel>().changeName(ip);
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter IP Address',
                        hintStyle: TextStyle(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryColor), // Set the text color to the primary color
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => Homepage()));
                              context.read<IpModel>().GetReq('1');
                            },
                            child: const Text("ON")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<IpModel>().GetReq('0');
                            },
                            child: const Text("OFF"))
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );

    // two buttons aligned horizontally
  }
}
