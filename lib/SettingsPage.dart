import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:savings_app/MainViewModel.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:currency_picker/currency_picker.dart';

import 'CustomDialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Settings'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.pinkAccent,
            ),
          ),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: const Text('General'),
              tiles: [
                SettingsTile(
                  title: const Text('Currency'),
                  value: Text('${mainViewModel.currencyCode}'),
                  leading: const Icon(Icons.attach_money),
                  onPressed: (BuildContext context) {
                    showCurrencyPicker(
                        context: context,
                        onSelect: (Currency currency) {
                          mainViewModel.setCurrency(currency);
                        });
                  },
                ),
                SettingsTile.switchTile(
                  title: const Text('Invest'),
                  leading: const Icon(Icons.pie_chart),
                  initialValue: mainViewModel.invest,
                  onToggle: (bool value) {
                    mainViewModel.switchInvest();
                  },
                ),
                SettingsTile(
                  title: const Text('Time Horizon'),
                  value: Text('${mainViewModel.timeHorizon} years'),
                  leading: const Icon(Icons.timer),
                  onPressed: (BuildContext context) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomDialog(
                          controller: mainViewModel.controller,
                          onPressed: () {
                            int value =
                                int.parse(mainViewModel.controller.text);
                            mainViewModel.setTimeHorizon(value);
                            mainViewModel.controller.clear();
                            Navigator.pop(context);
                          },
                          title: 'Time Horizon',
                          hintText: 'Enter time horizon in years',
                          formatter: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        );
                      },
                    );
                  },
                ),
                SettingsTile(
                    title: Text('Interest Rate'),
                    value: Text('${mainViewModel.interestRate} %'),
                    leading: const Icon(Icons.trending_up),
                    onPressed: (BuildContext context) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialog(
                            controller: mainViewModel.controller,
                            onPressed: () {
                              double value =
                                  double.parse(mainViewModel.controller.text);
                              mainViewModel.setInterestRate(value);
                              mainViewModel.controller.clear();
                              Navigator.pop(context);
                            },
                            title: 'Interest Rate',
                            hintText: 'Enter interest rate in %',
                            formatter: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'^(\d+)?\.?\d{0,2}')),
                            ],
                          );
                        },
                      );
                    }),
              ],
            )
          ],
        ));
  }
}
