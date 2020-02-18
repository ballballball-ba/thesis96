import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:mythesis96/m/car_data.dart';
import 'package:mythesis96/m/concert.dart';
import 'package:mythesis96/m/share_posts.dart';

class ConNotifier with ChangeNotifier {
  List<Concertview> _conList = [];
  Concertview _currentShare;

  UnmodifiableListView<Concertview> get shareList => UnmodifiableListView(_conList);

  Concertview get currentShare => _currentShare;

  set shareList(List<Concertview> conList) {
    _conList = conList;
    notifyListeners();
  }

  set currentShare(Concertview concertview) {
    _currentShare = concertview;
    notifyListeners();
  }

 
  
}
class ConNotifier2 with ChangeNotifier {
  List<Concertview> _conList = [];
  Concertview _currentShare;

  UnmodifiableListView<Concertview> get shareList => UnmodifiableListView(_conList);

  Concertview get currentShare => _currentShare;

  set shareList(List<Concertview> conList) {
    _conList = conList;
    notifyListeners();
  }

  set currentShare(Concertview concertview) {
    _currentShare = concertview;
    notifyListeners();
  }

 
  
}
class ConNotifier3 with ChangeNotifier {
  List<Concertview> _conList = [];
  Concertview _currentShare;

  UnmodifiableListView<Concertview> get shareList => UnmodifiableListView(_conList);

  Concertview get currentShare => _currentShare;

  set shareList(List<Concertview> conList) {
    _conList = conList;
    notifyListeners();
  }

  set currentShare(Concertview concertview) {
    _currentShare = concertview;
    notifyListeners();
  }

 
  
}