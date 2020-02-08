import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/share_posts.dart';

class ShareNotifier with ChangeNotifier {
  List<Share> _shareList = [];
  Share _currentShare;

  UnmodifiableListView<Share> get shareList => UnmodifiableListView(_shareList);

  Share get currentShare => _currentShare;

  set shareList(List<Share> shareList) {
    _shareList = shareList;
    notifyListeners();
  }

  set currentShare(Share share) {
    _currentShare = share;
    notifyListeners();
  }

  // addFood(Share food) {
  //   _foodList.insert(0, food);
  //   notifyListeners();
  // }

  // deleteFood(Share food) {
  //   _foodList.removeWhere((_food) => _food.id == food.id);
  //   notifyListeners();
  // }
}

class ShareNotifier2 with ChangeNotifier {
  List<Share> _shareList = [];
  Share _currentShare;

  UnmodifiableListView<Share> get shareList => UnmodifiableListView(_shareList);

  Share get currentShare => _currentShare;

  set shareList(List<Share> shareList) {
    _shareList = shareList;
    notifyListeners();
  }

  set currentShare(Share share) {
    _currentShare = share;
    notifyListeners();
  }

  // addFood(Share food) {
  //   _foodList.insert(0, food);
  //   notifyListeners();
  // }

  // deleteFood(Share food) {
  //   _foodList.removeWhere((_food) => _food.id == food.id);
  //   notifyListeners();
  // }
}

class ShareNotifier3 with ChangeNotifier {
  List<Share> _shareList = [];
  Share _currentShare;
  
  UnmodifiableListView<Share> get shareList => UnmodifiableListView(_shareList);

  Share get currentShare => _currentShare;

  set shareList(List<Share> shareList) {
    _shareList = shareList;
    notifyListeners();
  }

  set currentShare(Share share) {
    _currentShare = share;
    notifyListeners();
  }
}

class ShareNotifierrequest1 with ChangeNotifier {
  List<Sharereq> _shareList = [];
  Sharereq _currentShare;
  
  UnmodifiableListView<Sharereq> get shareList => UnmodifiableListView(_shareList);

  Sharereq get currentShare => _currentShare;

  set shareList(List<Sharereq> shareList) {
    _shareList = shareList;
    notifyListeners();
  }

  set currentShare(Sharereq share) {
    _currentShare = share;
    notifyListeners();
  }
}