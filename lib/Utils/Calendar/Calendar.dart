import 'package:coresystem/Components/base_component.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DateTimeCore.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker>
    with AutomaticKeepAliveClientMixin<DateTimePicker> {
  PageController _pageController;
  DateTime dateSelect = PickerDate.today;
  int pageSelect = 0;
  bool checkPage = true;
  List<DateTime> list = PickerDate.weekStartEnd(PickerDate.week);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateSelect = PickerDate.today;
    checkPage = true;
    pageSelect = 0;
    list = PickerDate.weekStartEnd(PickerDate.week);
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double wiD = (MediaQuery.of(context).size.width - 352) / 14;
    Radius rad = Radius.circular(24.5);
    return Container(
      height: 92,
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: List<Widget>.generate(7, (index) {
              return GestureDetector(
                onTap: () {},
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  margin: EdgeInsets.symmetric(horizontal: wiD),
                  width: 48,
                  decoration: (checkPage &&
                          DateFormat('EEEE')
                                  .format(list[index])
                                  .substring(0, 3) ==
                              DateFormat('EEEE')
                                  .format(dateSelect)
                                  .substring(0, 3))
                      ? BoxDecoration(
                          color: FColors.blue1.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.only(topLeft: rad, topRight: rad))
                      : BoxDecoration(),
                  child: FMediaView(
                    shape: FBoxShape.circle,
                    backgroundColor: FColors.transparent,
                    size: FBoxSize.size32,
                    child: Text(
                      "${DateFormat('EEEE').format(list[index]).substring(0, 3)}",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),
                  ),
                ),
              );
            }),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: PageView.builder(
              onPageChanged: (page) {
                setState(() {
                  checkPage = pageSelect == page;
                });
              },
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  children: List<Widget>.generate(7, (index1) {
                    var dayIndex = PickerDate.weekStartEnd(
                        PickerDate.week + index)[index1];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          pageSelect = index;
                          checkPage = true;
                          dateSelect = dayIndex;
                          PickerDate.dateSelect = dayIndex;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: EdgeInsets.symmetric(horizontal: wiD),
                        width: 48,
                        padding: EdgeInsets.only(bottom: 8.0),
                        decoration: (dayIndex == dateSelect)
                            ? BoxDecoration(
                                color: FColors.blue1.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: rad, bottomRight: rad))
                            : BoxDecoration(),
                        child: (dayIndex == dateSelect)
                            ? Column(
                                children: [
                                  Center(
                                    child: FMediaView(
                                      shape: FBoxShape.circle,
                                      size: FBoxSize.size32,
                                      backgroundColor: FColors.blue1,
                                      child: Container(
                                          padding: EdgeInsets.only(bottom: 3.0),
                                          child: Text(
                                            "${dayIndex.day}",
                                            style: FTextStyle.semibold14_22
                                                .copyWith(color: FColors.grey1),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Center(
                                    child: FMediaView(
                                      shape: FBoxShape.circle,
                                      size: FBoxSize.size32,
                                      backgroundColor: FColors.transparent,
                                      child: Container(
                                          padding: EdgeInsets.only(bottom: 3.0),
                                          child: Text(
                                            "${dayIndex.day}",
                                            style: FTextStyle.semibold14_22
                                                .copyWith(color: FColors.grey9),
                                          )),
                                    ),
                                  ),
                                  (PickerDate.today == dayIndex)
                                      ? FMediaView(
                                          size: FBoxSize(
                                            ratioValue: 1,
                                            value: 4,
                                            circleRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                            roundRadius: BorderRadius.all(
                                                Radius.circular(20.0)),
                                          ),
                                          backgroundColor: FColors.blue1,
                                          child: SizedBox(),
                                        )
                                      : Container()
                                ],
                              ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
