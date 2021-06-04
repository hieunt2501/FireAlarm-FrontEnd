import 'package:flutter/material.dart';

class MyDevices extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        // iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ), 
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('My Devices', style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SwitchListTile(
              value: true,
              title: Text("Sprinkle system", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              onChanged: (value) {}
            ),
            SwitchListTile(
              value: true,
              title: Text("Fan system", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              onChanged: (value) {}
            ),
            SwitchListTile(
              value: true,
              title: Text("Buzzer system", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
              onChanged: (value) {}
            )
          ],
        ),
      )
    );
  }
}