import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/user.dart';

import 'OrderWithPeople.dart';

class OffineOrderWithPeople extends OrderWithPeople{

  OffineOrderWithPeople(User user ,OffineOrder onlineOrder){
    this.user=user;
    this.order=onlineOrder;
  }
}
