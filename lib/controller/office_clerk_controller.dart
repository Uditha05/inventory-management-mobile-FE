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
          closeDate: null,
          image: oneB.equipment.imageUrl,
          issue: oneB.reason,
          itemId: oneB.id.toString(),
          model: oneB.equipment.modelName,
          openDate: oneB.openDate,
          status: oneB.equipment.status,
          storeCode: oneB.equipment.storeCode);

      newbrokens.add(brokenItem);
    }

    return newbrokens;
  }

  Future getPendingRepair() async {
    List<BrokenItem> pendingBroken = [];
    List<BrokenItems> out = await OfficeClerkService().getPendingRepairItems();
    if (out == null) {
      return pendingBroken;
    }
    for (var oneB in out) {
      BrokenItem brokenItem = new BrokenItem(
          category: oneB.equipment.category,
          closeDate: null,
          image: oneB.equipment.imageUrl,
          issue: oneB.reason,
          itemId: oneB.id.toString(),
          model: oneB.equipment.modelName,
          openDate: oneB.openDate,
          status: oneB.equipment.status,
          storeCode: oneB.equipment.storeCode);

      pendingBroken.add(brokenItem);
    }

    return pendingBroken;
  }

  Future getOldDamageItem() async {
    List<BrokenItem> pendingBroken = [];
    List<BrokenItems> out = await OfficeClerkService().getOldDamageItem();
    if (out == null) {
      return pendingBroken;
    }
    for (var oneB in out) {
      BrokenItem brokenItem = new BrokenItem(
          category: oneB.equipment.category,
          closeDate: oneB.closeDate.toString(),
          image: oneB.equipment.imageUrl,
          issue: oneB.reason,
          itemId: oneB.id.toString(),
          model: oneB.equipment.modelName,
          openDate: oneB.openDate,
          status: oneB.equipment.status,
          storeCode: oneB.equipment.storeCode);

      print("tttt ${oneB.closeDate.toString()}");

      pendingBroken.add(brokenItem);
    }

    return pendingBroken;
  }

  Future markSendToRepair(String id) async {
    var out = await OfficeClerkService().markSendToRepair(id);
    return out;
  }

  Future markAsFinished(String id) async {
    var out = await OfficeClerkService().markFinishedRepair(id);
    return out;
  }
}
