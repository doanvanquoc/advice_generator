import 'dart:convert';

import 'package:advice_generator/advice.dart';
import 'package:advice_generator/api_servide.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Advice advice =
      Advice(id: 0, advice: 'Press the button the generate advice');

  @override
  void initState() {
    super.initState();
    initAdvice();
  }

  Future initAdvice() async {
    print('got');
    final pref = await SharedPreferences.getInstance();
    final adviceJson = pref.getString('advice');
    setState(() {
      adviceJson != null
          ? advice = Advice.fromJson(jsonDecode(adviceJson))
          : Advice(id: 0, advice: 'Press the button the generate advice');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Advice Generator'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
          advice = await service.fetchAdvice();
          await service.saveToLocal(advice);
          setState(() {
            Navigator.pop(context);
          });
        },
        label: const Text('Generate Advice'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.format_quote),
                        Text(
                          '#Advice ${advice.id}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        const Icon(Icons.format_quote),
                      ],
                    ),
                  ),
                  Text(
                    '${advice.advice}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
