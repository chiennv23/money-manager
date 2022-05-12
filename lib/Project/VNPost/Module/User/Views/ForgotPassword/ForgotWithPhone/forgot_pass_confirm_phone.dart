import 'dart:async';

import 'package:coresystem/Components/base_component.dart';
import 'package:coresystem/Project/VNPost/Contains/constants.dart';
import 'package:coresystem/Project/VNPost/Contains/skin/skin_route.dart';
import 'package:coresystem/Project/VNPost/Module/User/Views/login.dart';
import 'package:coresystem/Utils/ConvertUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../../../../Core/routes.dart';
import '../../../../../../../Core/storageKeys_helper.dart';
import '../../../../../Contains/textform_with_example.dart';

class ForgotPConfirmPhone extends StatefulWidget {
  final String phoneNumber;

  const ForgotPConfirmPhone({Key key, this.phoneNumber}) : super(key: key);

  @override
  State<ForgotPConfirmPhone> createState() => _ForgotPConfirmPhoneState();
}

class _ForgotPConfirmPhoneState extends State<ForgotPConfirmPhone> {
  final codeController = TextEditingController();
  bool isLoading = false;
  bool oneClick = false;

  Timer _timer;
  int _start = 59;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool isCorrect = true;
  int falseTimes = 0; // số lần nhập sai mã Authen
  int countdown = 0; // thời gian khoá còn lại
  int countCD = 0;

  int countdownTimer = 0;
  int countFail = 0;
  String helperText = '';

  Timer timer;
  DateTime now = DateTime.now();
  var focusNode = FocusNode();

  @override
  void initState() {
    startTimer();
    init();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getTime());

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    focusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  void getTime() {
    setState(() {
      now = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    process();

    return Scaffold(
      backgroundColor: FColorSkin.grey1_background,
      appBar: appbarNoTitle(
          systemUiOverlayStyle: SystemUiOverlayStyle.dark,
          iconBack: FOutlined.left),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xác thực số điện thoại',
              style: FTypoSkin.title2.copyWith(color: FColorSkin.title),
            ),
            Container(
              padding: EdgeInsets.only(top: 4, bottom: 2),
              child: Text(
                'Hãy nhập mã xác thực được gửi tới số điện thoại:',
                style: FTypoSkin.subtitle2
                    .copyWith(color: FColorSkin.secondaryText),
              ),
            ),
            Text(
              '${widget.phoneNumber}'.replaceRange(3, 6, '***'),
              style: FTypoSkin.title5.copyWith(color: FColorSkin.primaryText),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 8,
              ),
              child: FTextButton(
                size: FButtonSize.size24.copyWith(padding: EdgeInsets.zero),
                child: Text(
                  'Thay đổi số điện thoại',
                  style: FTextStyle.regular14_22
                      .copyWith(color: FColorSkin.infoPrimary),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: isCorrect ? 21 : 0),
              child: FTextFormField(
                borderColor: FColorSkin.grey3_background,
                focusColor: FColorSkin.infoPrimary,
                labelText: 'Nhập mã xác thực',
                keyboardType: TextInputType.number,
                labelImportant: false,
                size: FInputSize.size64,
                textCapitalization: TextCapitalization.none,
                enabled: countdown == 0 ? true : false,
                onTap: () {},
                focusNode: focusNode,
                clearIcon: codeController.text.isEmpty
                    ? Container()
                    : FFilledButton.icon(
                        size: FButtonSize.size24,
                        backgroundColor: FColorSkin.transparent,
                        child: FIcon(
                          icon: FFilled.close_circle,
                          size: 16,
                          color: FColorSkin.subtitle,
                        ),
                        onPressed: () {
                          setState(codeController.clear);
                        }),
                onChanged: (vl) {
                  setState(() {});
                },
                onSubmitted: (vl) {},
                controller: codeController,
                maxLine: 1,
              ),
            ),
            AnimatedContainer(
              height: isCorrect ? 0 : 45,
              duration: Duration(milliseconds: 200),
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  isCorrect ? '' : helperText,
                  style:
                      FTextStyle.regular14_22.copyWith(color: FColors.red6),
                  textAlign: TextAlign.left,
                  key: ValueKey(helperText),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      'Chưa nhận được mã? ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: FTypoSkin.bodyText2
                          .copyWith(color: FColorSkin.secondaryText),
                    ),
                  ),
                  if (_start != 0)
                    Container(
                      child: Text(
                        'Yêu cầu mã mới trong ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: FTypoSkin.bodyText2
                            .copyWith(color: FColorSkin.subtitle),
                      ),
                    ),
                  if (_start != 0)
                    Container(
                      child: Text(
                        '00:$_start',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: FTypoSkin.bodyText2
                            .copyWith(color: FColorSkin.secondaryText),
                      ),
                    )
                  else
                    FTextButton(
                      size: FButtonSize.size24,
                      onPressed: () {
                        if (oneClick) {
                          return;
                        }
                        setState(() {
                          oneClick = true;
                        });
                      },
                      child: Text(
                        'Yêu cầu mã mới',
                        style: FTextStyle.regular14_22.copyWith(
                            color: oneClick
                                ? FColorSkin.disable
                                : FColorSkin.infoPrimary),
                      ),
                    )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 33,
              ),
              child: FFilledButton(
                size: FButtonSize.size40,
                onPressed: () {
                  if (codeController.text.isEmpty) {
                    return;
                  }
                  // validation
                  if (countdown == 0 && falseTimes < 5) {
                    ///CALL DATA IN HERE
                    var code = 200;
                    setState(() {
                      isLoading = true;
                    });
                    if (codeController.text == '200') {
                      correctAuthenticator();
                    } else {
                      codeController.clear();
                      setState(() {
                        isLoading = false;
                      });
                      incorrectAuthenticator();
                    }
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                isLoading: isLoading,
                backgroundColor: FColorSkin.primaryColor,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Xác nhận',
                    style: FTextStyle.regular14_22
                        .copyWith(color: FColorSkin.grey1_background),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future init() async {
    falseTimes = SharedPreferencesHelper.instance
            .getInt(key: 'false_${widget.phoneNumber}') ??
        0;
    countdown = SharedPreferencesHelper.instance
            .getInt(key: 'time_${widget.phoneNumber}') ??
        0;
    countFail = SharedPreferencesHelper.instance
            .getInt(key: 'countTimerFail_${widget.phoneNumber}') ??
        0;
    var _time = SharedPreferencesHelper.instance
            .getInt(key: 'countDownTimer_${widget.phoneNumber}') ??
        0;
    if (_time != countdownTimer) {
      setState(() {
        countdownTimer = _time;
      });
    }
  }

  Future process() async {
    falseTimes = SharedPreferencesHelper.instance
            .getInt(key: 'false_${widget.phoneNumber}') ??
        0;
    countdown = SharedPreferencesHelper.instance
            .getInt(key: 'time_${widget.phoneNumber}') ??
        0;
    if (countdown > 0 && falseTimes == 5) {
      isCorrect = false;
      countCD = countdown - WConvert.totalseconds(now);
      if (countCD <= 0) {
        setState(() {
          isCorrect = true;
          SharedPreferencesHelper.instance
              .removeKey(key: 'time_${widget.phoneNumber}');
          SharedPreferencesHelper.instance
              .removeKey(key: 'false_${widget.phoneNumber}');
          falseTimes = 0;
          countdown = 0;
          countCD = 0;
        });
      } else {
        var _timerCD = DateFormat('mm:ss').format(countCD.dateTime());
        setState(() {
          helperText = 'Bạn đã nhập sai nhiều lần! Thử lại sau $_timerCD';
        });
      }
    }
    if (countCD == 0) {
      if (mounted) {
        setState(() {
          focusNode.requestFocus();
        });
      }
    }
  }

  Future<void> incorrectAuthenticator() async {
    setState(() {
      isCorrect = false;
      falseTimes = falseTimes + 1;
      SharedPreferencesHelper.instance
          .setInt(key: 'false_${widget.phoneNumber}', val: falseTimes);
      helperText = falseTimes < 5
          ? 'Sai mã xác thực! Bạn còn 0${5 - falseTimes} lần thử lại'
          : '';
    });
    if (falseTimes == 5) {
      setState(() {
        countFail = countFail + 1;
        SharedPreferencesHelper.instance.setInt(
            key: 'countTimerFail_${widget.phoneNumber}', val: countFail);
      });

      if (countFail >= 1) {
        setState(() {
          countdownTimer = countdownTimer + 30;
          SharedPreferencesHelper.instance.setInt(
              key: 'countDownTimer_${widget.phoneNumber}', val: countdownTimer);
        });
      }
      var _countdown = WConvert.totalseconds(DateTime.now()) + countdownTimer;
      setState(() {
        SharedPreferencesHelper.instance
            .setInt(key: 'time_${widget.phoneNumber}', val: _countdown);
      });
    }
  }

  Future<void> correctAuthenticator() async {
    setState(() {
      isCorrect = true;
      SharedPreferencesHelper.instance
          .removeKey(key: 'time_${widget.phoneNumber}');
      SharedPreferencesHelper.instance
          .removeKey(key: 'false_${widget.phoneNumber}');
      SharedPreferencesHelper.instance
          .removeKey(key: 'countTimerFail_${widget.phoneNumber}');
      SharedPreferencesHelper.instance
          .removeKey(key: 'countDownTimer_${widget.phoneNumber}');

      falseTimes = 0;
      countdown = 0;
      countCD = 0;
    });
    await CoreRoutes.instance.navigateAndRemoveRoutes(Login(
      type: 2,
    ));
  }
}
