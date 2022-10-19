import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:savings_app/MainViewModel.dart';

import 'CustomDialog.dart';
import 'SettingsPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Savings App"),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            child: const Icon(Icons.settings)),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have saved:',
                    ),
                    Text(
                      mainViewModel
                          .getFormattedCurrency(mainViewModel.savedAmount),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'In ${mainViewModel.timeHorizon} years:',
                    ),
                    Text(
                      mainViewModel.getFormattedCurrency(
                          mainViewModel.getInvestmentReturn()),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
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
                      return CustomDialog(
                        controller: mainViewModel.controller,
                        onPressed: () {
                          int value = int.parse(mainViewModel.controller.text);
                          mainViewModel.addSavings(value);
                          mainViewModel.controller.clear();
                          Navigator.pop(context);
                        },
                        title: 'Add Savings',
                        hintText: 'Enter amount',
                        formatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
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
