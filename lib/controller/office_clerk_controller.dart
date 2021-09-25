import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/model/response/broken_item_model.dart';
import 'package:inventory_management/service/office_clerk_service.dart';

class OfficeClerkController {
  Future getNewDamages() async {
    List<BrokenItem> newbrokens = [];
    List<BrokenItems> out = await OfficeClerkService().getNewDamageItems();
    if (out == null) {
      return newbrokens;
    }
    for (var oneB in out) {
      BrokenItem brokenItem = new BrokenItem(
          category: oneB.equipment.category,
          closeDate: oneB.closeDate,
          image: oneB.equipment.imageUrl,
          issue: oneB.reason,
          itemId: oneB.id.toString(),
          model: oneB.equipment.modelName,
          openDate: oneB.openDate,
          status: oneB.equipment.status,
          storeCode:
              oneB.equipment.labName + "-" + oneB.equipment.id.toString());

      newbrokens.add(brokenItem);
    }

    return newbrokens;
  }
}
