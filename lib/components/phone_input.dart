import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInput extends StatefulWidget {
  final ValueChanged<String> onPhoneNumberTyped;
  PhoneInput({@required this.onPhoneNumberTyped});
  @override
  State<StatefulWidget> createState() => PhoneInputState();
}

class PhoneInputState extends State<PhoneInput> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height / 15,
      width: width * 0.92,
      child: Row(
        children: [
          Container(
            height: height / 15,
            width: width * 0.23,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'lib/images/vietnam-flag.jpg',
                scale: 3,
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Text("+84"),
            ]),
          ),
          SizedBox(
            width: width * 0.025,
          ),
          Container(
              padding: EdgeInsets.all(10),
              height: height / 15,
              width: width * 0.665,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextFormField(
                onChanged: (phone) {
                  widget.onPhoneNumberTyped(phone);
                },
                controller: controller,
                cursorColor: Colors.black,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Số điện thoại"),
              ))
          //TextFormField()
        ],
      ),
    );
  }
}
