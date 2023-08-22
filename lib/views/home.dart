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
  String word = '';
  bool isClick = true;

  onClick() async {
    word = textController.text.toString().trim();
    defList = await DictonaryServices.fetchDefintiion(word: word);
    setState(() {
      value = defList[0].definition;
      isClick = false;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 107, 107, 107),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search word",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: textController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter World",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: Colors.grey, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 300,
                child: isClick
                    ? const Text(
                        'Search result....',
                        style: TextStyle(color: Colors.grey),
                      )
                    : ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
