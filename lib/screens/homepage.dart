// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:translator/service/translation_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  String inputLanguage = "en";
  String outputLanguage = "hi";
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Text Translation",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.white38,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LanguageButton(language: "English"),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Icon(Icons.multiple_stop),
                    ),
                    LanguageButton(language: "Hindi"),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Translate From ",
                      style: TextStyle(fontSize: 18, color: Colors.white38),
                    ),
                    Text(
                      inputLanguage,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                InputTextField(
                  controller: _inputController,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Translate to ",
                      style: TextStyle(fontSize: 18, color: Colors.white38),
                    ),
                    Text(
                      outputLanguage,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                OutputTextField(controller: _outputController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  const InputTextField({
    super.key,
    required this.controller,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  void initState() {
    widget.controller.addListener(_updateCharCount);
    super.initState();
  }

  int _charCount = 0;
  final int _maxCharCount = 200;

  void _updateCharCount() {
    setState(() {
      _charCount = widget.controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        // constraints: BoxConstraints.expand(width: double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF232527),
        ),
        child: TextField(
          maxLines: null,
          minLines: null,
          expands: true,
          controller: widget.controller,
          maxLength: _maxCharCount,
          decoration: InputDecoration(
            fillColor: Colors.red,
            focusColor: Colors.transparent,
            hintText: "Enter Text",
            hintStyle: TextStyle(color: Colors.white38),
            counterText: "${_charCount.toString()}/${_maxCharCount.toString()}",
            // contentPadding: EdgeInsets.only(bottom: 20),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white38),
            ),
            counterStyle: TextStyle(
                color:
                    (_charCount == _maxCharCount) ? Colors.red : Colors.white),
          ),
        ));
  }
}

class OutputTextField extends StatefulWidget {
  final TextEditingController controller;
  const OutputTextField({
    super.key,
    required this.controller,
  });

  @override
  State<OutputTextField> createState() => _OutputTextFieldState();
}

class _OutputTextFieldState extends State<OutputTextField> {
  int _charCount = 0;
  final int _maxCharCount = 200;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateCharCount);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  void _updateCharCount() {
    setState(() {
      _charCount = widget.controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        // constraints: BoxConstraints.expand(width: double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF232527),
        ),
        child: TextField(
          maxLines: null,
          minLines: null,
          expands: true,
          controller: widget.controller,
          maxLength: _maxCharCount,
          enabled: false,
          decoration: InputDecoration(
            fillColor: Colors.red,
            focusColor: Colors.transparent,
            hintText: "Enter Text",
            hintStyle: TextStyle(color: Colors.white38),
            counterText: "${_charCount.toString()}/${_maxCharCount.toString()}",
            // contentPadding: EdgeInsets.only(bottom: 20),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white38),
            ),
            counterStyle: TextStyle(
                color:
                    (_charCount == _maxCharCount) ? Colors.red : Colors.white),
          ),
        ));
  }
}

class LanguageButton extends StatelessWidget {
  final String language;
  const LanguageButton({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF232527),
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 15,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  language,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
