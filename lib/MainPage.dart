import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:savings_app/MainViewModel.dart';

import 'CustomDialog.dart';
import 'SettingsPage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _moneyAnimationController;
  String _pigUrl =
      'https://assets8.lottiefiles.com/packages/lf20_yvwcdrrw.json';

  final List<String> _randomPigAnimations = [
    'https://assets3.lottiefiles.com/packages/lf20_u70phlit.json',
    'https://assets3.lottiefiles.com/packages/lf20_id5yltov.json'
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
    );
    _moneyAnimationController = AnimationController(
      vsync: this,
    );
    timer = Timer.periodic(
        Duration(seconds: 30), (Timer t) => runRandomAnimation());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void runRandomAnimation() {
    if (!_animationController.isAnimating) {
      setState(() {
        _pigUrl = (_randomPigAnimations..shuffle()).first;
      });
      _animationController.reset();

      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Savings App"),
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            child: const Icon(Icons.settings, color: Colors.pinkAccent)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                if (mainViewModel.invest) ...[
                  const SizedBox(
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
                ]
              ],
            ),
            Lottie.network(_pigUrl,
                height: 500,
                repeat: false,
                controller: _animationController, onLoaded: (composition) {
              _animationController
                ..duration = composition.duration
                ..forward();
            }),
            TextButton(
                child: const Text('ADD'),
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(104, 181, 118, 1)),
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

                          _showOverlay(context);

                          _pigUrl =
                              'https://assets8.lottiefiles.com/packages/lf20_yvwcdrrw.json';
                          _animationController.reset();
                          _animationController.forward();
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

  void _showOverlay(BuildContext context) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Center(
          child: Lottie.network(
              'https://assets2.lottiefiles.com/packages/lf20_wwhhicx3.json',
              height: 500,
              repeat: false,
              controller: _moneyAnimationController, onLoaded: (composition) {
        _moneyAnimationController
          ..duration = composition.duration
          ..forward();
      }));
    });
    // animationController!.addListener(() {
    //   overlayState!.setState(() {});
    // });
    // _moneyAnimationController.repeat();
    overlayState.setState(() {});
    if (_moneyAnimationController.duration != null) {
      _moneyAnimationController.reset();
      _moneyAnimationController.forward();
    }

    // inserting overlay entry
    overlayState.insert(overlayEntry);
    _moneyAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        overlayEntry.remove();
      }
    });
  }
}
