import 'package:acazia_test/blocs/home_bloc/home_bloc.dart';
import 'package:acazia_test/model/user_model.dart';
import 'package:acazia_test/utils/global.dart';
import 'package:acazia_test/utils/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  User currenUser;
  CardController controller;
  HomeBloc bloc;
  bool isRightSwipping = false;
  @override
  void initState() {
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
            body: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: TinderSwapCard(
                  swipeUp: false,
                  swipeDown: false,
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: users.length,
                  // stackNum: 2,
                  swipeEdge: 4.0,
                  maxWidth: Screen.width * 0.9,
                  maxHeight: Screen.width * 0.9,
                  minWidth: Screen.width * 0.8,
                  minHeight: Screen.width * 0.8,
                  cardBuilder: (context, index) {
                    currenUser = users[index];
                    return Card(
                      color: Colors.green,
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                    );
                  },
                  cardController: controller,
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
                    } else if (align.x > 0) {
                      //Card is RIGHT swiping
                      isRightSwipping = true;
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!
                    if (isRightSwipping) {
                      bloc.add(StoreAsFav(user: users[index]));
                    } else {
                      bloc.add(GetUser());
                    }
                  },
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, HomeState state) {
          if (state is GetUserSuccess) {
            users.add(state.user);
          }
          if (state is StoreAsFavSuccess) {
            showMessage(message: "Đã thích!");
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
