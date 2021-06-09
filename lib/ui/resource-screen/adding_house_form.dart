import 'dart:convert';

import 'package:firealarm/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'House.dart';
import 'Room.dart';

class AddingHouseForm extends StatefulWidget {
  final ValueChanged<House> onHouseAdded;

  const AddingHouseForm({@required this.onHouseAdded});
  @override
  _AddingHouseFormState createState() => _AddingHouseFormState();
}

class _AddingHouseFormState extends State<AddingHouseForm> {
  List<Room> rooms = [];
  String name;
  String address;
  String lat;
  String lng;

  Future<int> addHouse(
      String name, String address, String lat, String lng) async {
    String body = json.encode({
      "AccountId": "0",
      "name": name,
      "address": address,
      "longtitude": lat,
      "latitude": lng,
      "rooms": rooms.map((e) => e.toJson()).toList()
    });
    final response = await http.post(
        Uri.https(APIs.baseResourceUrl, APIs.house),
        body: body,
        headers: {
          "Authorization": APIs.userToken,
          'Content-Type': 'application/json; charset=UTF-8'
        });
    return json.decode(response.body)['data']['id'];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InputForm(title: "Name", onChanged: (value) => name = value),
          _InputForm(title: "Address", onChanged: (value) => address = value),
          _InputForm(title: "Longtitude", onChanged: (value) => lng = value),
          _InputForm(title: "Latitude", onChanged: (value) => lat = value),
          SizedBox(
            height: 15,
          ),
          Text("Your rooms:"),
          Expanded(
              child: SizedBox(
                  width: 500,
                  child: rooms.length == 0
                      ? Center(
                          child: Text("No room yet"),
                        )
                      : ListView.builder(
                          itemCount: rooms.length,
                          itemBuilder: (context, index) => ListTile(
                                title: GestureDetector(
                                    child: Text(rooms[index].name),
                                    onTap: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            title: Text(
                                                "Room " + rooms[index].name),
                                            content: Text(
                                                rooms[index].description)))),
                                trailing: MaterialButton(
                                  child: Icon(
                                    Icons.delete,
                                  ),
                                  onPressed: () =>
                                      setState(() => rooms.removeAt(index)),
                                ),
                              )))),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          String roomName;
                          String description;
                          return AlertDialog(
                              title: Text("Add a room"),
                              content: SizedBox(
                                height: 300,
                                child: Column(
                                  children: [
                                    _InputForm(
                                        title: "Room name",
                                        onChanged: (value) => roomName = value),
                                    _InputForm(
                                        title: "Room description",
                                        onChanged: (value) =>
                                            description = value),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (roomName != null &&
                                                  description != null) {
                                                rooms.add(Room(
                                                    name: roomName,
                                                    description: description));

                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: Text("Add"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  },
                  child: Text("Add a room")),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (name != null &&
                          address != null &&
                          lng != null &&
                          lat != null) {
                        print("aloloolo");
                        House house = House(
                            id: await addHouse(name, address, lat, lng),
                            name: name,
                            address: address);
                        widget.onHouseAdded(house);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Add house"),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _InputForm extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String title;
  _InputForm({@required this.title, @required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        onChanged(value);
      },
      cursorColor: Colors.black,
      decoration: new InputDecoration(hintText: title),
    );
  }
}
