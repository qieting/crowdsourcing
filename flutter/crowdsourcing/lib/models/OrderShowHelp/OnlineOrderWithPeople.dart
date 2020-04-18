

import 'package:crowdsourcing/models/OrderShowHelp/OrderWithPeople.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/user.dart';

class OnlineOrderWithPeople extends OrderWithPeople{

  OnlineOrderWithPeople(User user ,OnlineOrder onlineOrder){
    this.user=user;
    this.order=onlineOrder;
  }


}