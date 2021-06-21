import 'dart:convert';

import 'package:firealarm/constants/api.dart';
import 'package:firealarm/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'House.dart';
import 'Room.dart';
import 'adding_house_form.dart';
import 'device_screen.dart';

class ResourceScreen extends StatefulWidget {
  @override
  _ResourceScreenState createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  int current = 0;
  List<House> houses = [];
  List<Room> rooms = [];
  final Map<String, Map<String, String>> roomDevices = {};

  Future<void> getHousesAndRooms() async {
    final responseHouse = await http
        .get(Uri.https(APIs.baseResourceUrl, APIs.myHouses), headers: {
      "Authorization": APIs.userToken,
      'Content-Type': 'application/json; charset=UTF-8'
    });
    final responseRoom =
        await http.get(Uri.https(APIs.baseResourceUrl, APIs.myRooms), headers: {
      "Authorization": APIs.userToken,
      'Content-Type': 'application/json; charset=UTF-8'
    });
    if (responseHouse.statusCode == 200 && responseRoom.statusCode == 200) {
      setState(() {
        Iterable i1 = json.decode(responseHouse.body)['data'];
        houses = List<House>.from(i1.map((e) => House.fromJson(e)).toList());
        Iterable i2 = json.decode(responseRoom.body)['data'];
        rooms = List<Room>.from(i2.map((e) => Room.fromJson(e)).toList());
        // for (Room r in rooms) {
        //   print(r.name);
        //   print(r.description);
        // }
      });
    }
  }

  Future<void> getDevicesforRooms() async {
    final responseDevies = await http
        .get(Uri.https(APIs.baseResourceUrl, APIs.myDevices), headers: {
      "Authorization": APIs.userToken,
      'Content-Type': 'application/json; charset=UTF-8'
    });
    if (responseDevies.statusCode == 200) {
      setState(() {
        Iterable iterate = json.decode(responseDevies.body)['data'];
        for (var i in iterate) {
          if (i["device"]["name"] == "Buzzer" ||
              i["device"]["name"] == "Despensor") {
            roomDevices.putIfAbsent(i["room"]["name"], () => {});
            roomDevices[i["room"]["name"]]
                .putIfAbsent(i["id"].toString(), () => i["device"]["name"]);
          }
        }
      });
      print(roomDevices);
    }
  }

  @override
  void initState() {
    super.initState();
    getHousesAndRooms();
    getDevicesforRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: ToggleSwitch(
                minWidth: 120,
                initialLabelIndex: current,
                icons: [Icons.home, Icons.window],
                activeBgColor: Colors.lightBlueAccent,
                inactiveBgColor: Colors.blueGrey,
                inactiveFgColor: Colors.grey,
                labels: ['My houses', 'My rooms'],
                onToggle: (index) {
                  setState(() {
                    current = index;
                  });
                },
              ))
        ],
      ),
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.statBar[1]),
          padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
              SizedBox(
                  height: 520,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: houses.length == 0
                        ? Center(child: CircularProgressIndicator())
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                            itemCount:
                                current == 0 ? houses.length : rooms.length,
                            itemBuilder: (context, index) => Card(
                                  elevation: 20,
                                  shadowColor: Colors.amber,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.indigo,
                                          Colors.black
                                        ]),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: RawMaterialButton(
                                          onPressed: () => {
                                            if (current == 0)
                                              {}
                                            else
                                              {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DeviceScreen(
                                                              deviceIdName:
                                                                  roomDevices[rooms[
                                                                          index]
                                                                      .name])),
                                                )
                                              }
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 20),
                                              ),
                                              Text(
                                                current == 0
                                                    ? houses[index].name
                                                    : rooms[index].name,
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    color: Colors.white),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 30),
                                              ),
                                              SizedBox(
                                                  child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        current == 0
                                                            ? "ID: " +
                                                                houses[index]
                                                                    .id
                                                                    .toString()
                                                            : "",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(width: 50)
                                                    ],
                                                  ),
                                                  Text(
                                                    current == 0
                                                        ? "Addr: " +
                                                            houses[index]
                                                                .address
                                                        : "",
                                                    style: TextStyle(
                                                        fontSize: 19,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ))
                                            ],
                                          ),
                                        ),
                                      )),
                                )),
                  ))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: AppColors.normalBackground[0],
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: AddingHouseForm(
                    onHouseAdded: (value) => setState(() {
                      houses.add(value);
                    }),
                  ),
                );
              });
        },
      ),
    );
  }
}
