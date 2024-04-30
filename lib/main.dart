import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  runApp((const ProviderScope(
    child: MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Number',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

// State notifier for generating a random number exposesd by a state notifier
// provider

class RandomNumberGenerator extends StateNotifier<int> {
  RandomNumberGenerator() : super(Random().nextInt(999));

  void generate() {
    state = Random().nextInt(999);
  }
}

final generatorRandom =
    StateNotifierProvider<RandomNumberGenerator, int>((ref) {
  return RandomNumberGenerator();
});

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Random Number'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Randomconsumer(),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                      onPressed: () =>
                          ref.read(generatorRandom.notifier).generate(),
                      child: const Text('Generate'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Randomconsumer extends ConsumerWidget {
  const Randomconsumer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(ref.watch(generatorRandom).toString());
  }
}
