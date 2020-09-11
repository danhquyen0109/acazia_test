import 'package:acazia_test/blocs/home_bloc/home_bloc.dart';
import 'package:acazia_test/model/user_model.dart';
import 'package:acazia_test/utils/global.dart';
import 'package:acazia_test/utils/screen.dart';
import 'package:acazia_test/view/wigets/profile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import '../../blocs/home_bloc/home_bloc.dart';
import '../../utils/global.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User currenUser;
  CardController controller;
  HomeBloc bloc;
  bool isRightSwipping = false;
  bool isLeftSwipping = false;

  List<User> users = [];
  @override
  void initState() {
    // user = User();
    bloc = HomeBloc();
    bloc.add(GetUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
          return Scaffold(
            backgroundColor: Colors.grey,
            body: Center(
              child: (state is GetUserOnLoading ||
                      state is StoreOnLoading ||
                      users.isEmpty)
                  ? CupertinoActivityIndicator()
                  : TinderSwapCard(
                      animDuration: 500,
                      maxHeight: Screen.width * 0.9,
                      minHeight: Screen.width * 0.8,
                      maxWidth: Screen.width * 0.9,
                      minWidth: Screen.width * 0.8,
                      cardBuilder: (context, index) {
                        return index == 0
                            ? ProfileCard(
                                user: users[index],
                                height: Screen.width * 0.9,
                                width: Screen.width * 0.9,
                              )
                            : Container();
                      },
                      totalNum: users.length,
                      cardController: controller,
                      allowVerticalMovement: false,
                      swipeUpdateCallback: (details, align) {
                        if (align.x < -3) {
                          // LEFT
                          isLeftSwipping = true;
                        } else if (align.x > 3) {
                          //RIGHT
                          isRightSwipping = true;
                        }
                      },
                      swipeCompleteCallback: (orientation, index) {
                        if (isRightSwipping) {
                          bloc.add(StoreAsFav(user: users[index]));
                          bloc.add(GetUser());
                        }
                        if (isLeftSwipping) {
                          bloc.add(GetUser());
                        }
                        isLeftSwipping = false;
                        isRightSwipping = false;
                      },
                    ),
            ),
          );
        },
        listener: (BuildContext context, HomeState state) {
          if (state is GetUserSuccess) {
            users = [state.user];
          }
          if (state is GetUserFail) {
            showMessage(message: "Không thành công");
          }
          if (state is StoreAsFavSuccess) {
            showMessage(message: "Đã thích!");
            List<String> _result =
                storage?.getStringList("favorite_users") ?? [];
            print(_result.length);
          }
          if (state is StoreAsFavFail) {
            showMessage(message: "Lỗi hệ thống");
          }
        },
      ),
    );
    // return Scaffold(
    //   body: Container(),
    // );
  }
}
