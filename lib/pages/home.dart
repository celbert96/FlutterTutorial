import 'package:flutter/material.dart';

import '../services/world_time.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WorldTime worldTime;

  @override
  Widget build(BuildContext context) {
    worldTime = ModalRoute.of(context)?.settings.arguments as WorldTime;

    String bgImage = worldTime.isDaytime ? 'day.png' : 'night.png';
    Color? bgColor = worldTime.isDaytime ? Colors.blue : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        if(result != null) {
                          setState(() {
                            WorldTime r = result as WorldTime;

                            worldTime.location = r.location;
                            worldTime.isDaytime = r.isDaytime;
                            worldTime.flag = r.flag;
                            worldTime.url = r.url;
                            worldTime.time = r.time;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                        "Edit Location",
                        style: TextStyle(color: Colors.grey[300]
                        ),
                      )
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        worldTime.location,
                        style: const TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    worldTime.time,
                    style: const TextStyle(
                      fontSize: 66,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
