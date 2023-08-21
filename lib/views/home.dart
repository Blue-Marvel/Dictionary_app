import 'package:flutter/material.dart';
import 'package:dictionary_app/models/dictionary_model.dart';
import 'package:dictionary_app/services/dictionary_services.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({super.key});

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  List<Definition> defList = [];
  TextEditingController textController = TextEditingController();
  String value = 'Enter word to search';
  String word = 'me';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  onClick() {
    setState(() {
      word = textController.text.toString().trim();
      value = defList[0].definition;
    });
  }

  _getData() async {
    defList = await DictonaryServices.fetchDefintiion(word: word);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Focus.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dictionary App',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.blue,
                          width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.blue,
                          width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(value),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onClick,
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
