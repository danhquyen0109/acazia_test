import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../utils/global.dart';
import '../../utils/global.dart';
import '../../utils/global.dart';

class ProfileCard extends StatefulWidget {
  final User user;
  final double height;
  final double width;

  ProfileCard(
      {Key key,
      @required this.user,
      @required this.height,
      @required this.width})
      : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool nameOnChoose = true;
  bool dateOnChoose = false;
  bool addressOnChoose = false;
  bool phoneOnChoose = false;
  bool loginOnChoose = false;
  String content = "";
  @override
  void initState() {
    if (widget.user != null) {
      content = formatName(widget.user.name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.user != null
        ? Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            child: Stack(
              children: [
                Positioned(
                  top: widget.height / 3,
                  child: Container(
                    height: widget.height * 2 / 3,
                    width: widget.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 1.0,
                        ),
                        SizedBox(
                          height: widget.height / 9 + 12.0,
                        ),
                        Text(content),
                        Expanded(
                          child: SizedBox(),
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                splashRadius: 1.0,
                                icon: Icon(
                                  Icons.account_circle,
                                  color: nameOnChoose
                                      ? Colors.greenAccent
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setButtonsColor(1);
                                  setContent(1);
                                },
                              ),
                              IconButton(
                                splashRadius: 1.0,
                                icon: Icon(
                                  Icons.date_range,
                                  color: dateOnChoose
                                      ? Colors.greenAccent
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setButtonsColor(2);
                                  setContent(2);
                                },
                              ),
                              IconButton(
                                splashRadius: 1.0,
                                icon: Icon(
                                  Icons.location_on,
                                  color: addressOnChoose
                                      ? Colors.greenAccent
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setButtonsColor(3);
                                  setContent(3);
                                },
                              ),
                              IconButton(
                                splashRadius: 1.0,
                                icon: Icon(
                                  Icons.phone,
                                  color: phoneOnChoose
                                      ? Colors.greenAccent
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setButtonsColor(4);
                                  setContent(4);
                                },
                              ),
                              IconButton(
                                splashRadius: 1.0,
                                icon: Icon(
                                  Icons.lock,
                                  color: loginOnChoose
                                      ? Colors.greenAccent
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setButtonsColor(5);
                                  setContent(5);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: widget.height / 9,
                  left: widget.width / 3,
                  child: Container(
                    height: widget.height / 3,
                    width: widget.width / 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(widget.width / 6)),
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey,
                        )),
                    child: Center(
                      child: Container(
                        height: widget.height / 3 - 10,
                        width: widget.width / 3 - 10,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(widget.width / 6 - 5),
                          child: Image.network(
                            "${widget.user.picture.medium}",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: CupertinoActivityIndicator(),
          );
  }

  void setContent(int index) {
    switch (index) {
      case 1:
        setState(() {
          content = formatName(widget.user.name);
        });
        break;
      case 2:
        setState(() {
          content = widget.user.dob;
        });
        break;
      case 3:
        setState(() {
          content = formatAddress(widget.user.location.street +
              " " +
              widget.user.location.city +
              " " +
              widget.user.location.state);
        });
        break;
      case 4:
        setState(() {
          content = widget.user.phone;
        });
        break;
      case 5:
        setState(() {
          content = widget.user.login.username;
        });
        break;
      default:
        content = widget.user.name;
        break;
    }
  }

  void setButtonsColor(int index) {
    switch (index) {
      case 1:
        setState(() {
          nameOnChoose = true;
          dateOnChoose = false;
          addressOnChoose = false;
          phoneOnChoose = false;
          loginOnChoose = false;
        });
        break;
      case 2:
        setState(() {
          nameOnChoose = false;
          dateOnChoose = true;
          addressOnChoose = false;
          phoneOnChoose = false;
          loginOnChoose = false;
        });
        break;
      case 3:
        setState(() {
          nameOnChoose = false;
          dateOnChoose = false;
          addressOnChoose = true;
          phoneOnChoose = false;
          loginOnChoose = false;
        });
        break;
      case 4:
        setState(() {
          nameOnChoose = false;
          dateOnChoose = false;
          addressOnChoose = false;
          phoneOnChoose = true;
          loginOnChoose = false;
        });
        break;
      case 5:
        setState(() {
          nameOnChoose = false;
          dateOnChoose = false;
          addressOnChoose = false;
          phoneOnChoose = false;
          loginOnChoose = true;
        });
        break;
    }
  }
}
