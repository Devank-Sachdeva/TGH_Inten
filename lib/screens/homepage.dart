// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_final_fields, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:translator/language_codes_map.dart';
import 'package:translator/service/translation_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _translate() async {
    String inputText = _inputController.text;
    // String outputText = "hello";
    String outputText = await TranslationHandler.instance
        .translate(inputText, inputLanguage, outputLanguage);
    setState(() {
      _outputController.text = outputText;
    });
  }

  Future<String> detection(String text) async {
    final String response =
        await TranslationHandler.instance.getDetection(text);
    return languageMap[response] ?? "";
  }

  @override
  void initState() {
    _inputController.addListener(_translate);

    super.initState();
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  String inputLanguage = "";
  String outputLanguage = "";
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
                    LanguageButton(
                      languageMap: languageMap,
                    ),
                    Container(
                      margin: EdgeInsets.all(8),
                      child: Icon(Icons.multiple_stop),
                    ),
                    LanguageButton(languageMap: languageMap),
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
                CustomTextField(
                  controller: _inputController,
                  isInput: true,
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
                CustomTextField(
                  controller: _outputController,
                  isInput: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isInput;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.isInput,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
          enabled: (widget.isInput) ? true : false,
          decoration: InputDecoration(
            fillColor: Colors.red,
            focusColor: Colors.transparent,
            hintText: "Enter Text",
            hintStyle: TextStyle(color: Colors.white38),
            counterText: "${_charCount.toString()}/${_maxCharCount.toString()}",
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

class LanguageButton extends StatefulWidget {
  String? selectedLanguage;
  String? get getName => selectedLanguage;
  final Map<String, String> languageMap;
  LanguageButton({
    super.key,
    required this.languageMap,
  });

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  late List<String> codeList;

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
          onPressed: () async {
            codeList = await TranslationHandler.instance.getLanguages();
            return showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 350,
                  child: ListView.builder(
                    itemCount: codeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      
                      return ListTile(
                        title: Text(widget.languageMap[codeList[index]]?? "Unknown"),
                        onTap: () {
                          setState(() {
                            widget.selectedLanguage =
                                widget.languageMap[codeList[index]]!;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
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
                  widget.selectedLanguage ?? "Select language",
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
