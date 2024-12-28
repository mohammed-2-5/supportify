import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomSwitchTile extends StatefulWidget {
  const CustomSwitchTile({super.key});

  @override
  _CustomSwitchTileState createState() => _CustomSwitchTileState();
}

class _CustomSwitchTileState extends State<CustomSwitchTile> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(

      title: const Text('Remember me',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black, // Change to match your text color
            // Adjust other styles as needed
          )),
      value: isSwitched,
      onChanged: (newValue) {
        setState(() {
          isSwitched = newValue;
        });
      },

      activeTrackColor:  Color(0xff388175), // Color of the track when switch is on
      activeColor: Colors.white, // Color of the thumb when switch is on
      contentPadding: EdgeInsets.zero, // Adjust the padding as needed
      controlAffinity: ListTileControlAffinity.leading, // places the switch at the start
      // You can adjust other styling as needed
    );
  }
}
