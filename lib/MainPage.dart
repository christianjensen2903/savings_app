import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:savings_app/MainViewModel.dart';

import 'AddSavingsDialog.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Savings App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have saved:',
            ),
            Text(
              '${mainViewModel.savedAmount}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
                child: const Text('ADD'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddSavingsDialog(
                        controller: mainViewModel.controller,
                        onPressed: () {
                          int value = int.parse(mainViewModel.controller.text);
                          mainViewModel.addSavings(value);
                          mainViewModel.controller.clear();
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
