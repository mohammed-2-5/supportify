import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isPasswordField;
  final IconData? icon;
  final String hintLabel;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const InputField({
    Key? key,
    required this.label,
    this.isPasswordField = false,
     this.icon,
    required this.hintLabel, this.controller, this.validator, this.onChanged, this.onTap,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPasswordField; // Set initial visibility based on isPasswordField
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
        onTap: widget.onTap,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            // Trigger form validation on change
            widget.controller?.value = TextEditingValue(
              text: value,
              selection: widget.controller!.selection,
            );
          },

          focusNode: FocusNode(),
          validator: widget.validator,
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: widget.hintLabel,
            hintStyle: const TextStyle(color: Color(0xffB9C2C0)),
            prefixIcon: Icon(widget.icon, color: Colors.grey.shade500),
            suffixIcon: widget.isPasswordField
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey.shade500,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
