import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/model/office_clerk_related/broken_item_model.dart';
import 'package:inventory_management/model/office_clerk_related/repairModel.dart';
import 'package:inventory_management/service/office_clerk_service.dart';

class OfficeClerkController {
  Future getNewDamages() async {
    List<BrokenItem> newbrokens = [];
    List<DamageModel> out = await OfficeClerkService().getNewDamageItems();
    if (out == null) {
      return newbrokens;
    }
    for (var oneB in out) {
      BrokenItem brokenItem = new BrokenItem(
          category: oneB.categoryCategoryName,
          closeDate: null,
          image: oneB.imageUrl,
          issue: oneB.reason,
          itemId: oneB.id.toString(),
          damageId: oneB.damageId.toString(),
          model: oneB.modelModelName,
          openDate: oneB.openDate,
          status: oneB.status,
          storeCode: oneB.id);

      newbrokens.add(brokenItem);
    }

    return newbrokens;
  }

  Future getPendingRepair() async {
    List<BrokenItem> pendingBroken = [];
    List<DamageModel> out = await OfficeClerkService().getPendingRepairItems();
    if (out == null) {
      return pendingBroken;
    }
    for (var oneB in out) {
      BrokenItem brokenItem = new BrokenItem(
          category: oneB.categoryCategoryName,
          closeDate: null,
          image: oneB.imageUrl,
          issue: oneB.reason,
          damageId: oneB.damageId.toString(),
          itemId: oneB.id.toString(),
          model: oneB.modelModelName,
          openDate: oneB.openDate,
          status: oneB.status,
          storeCode: oneB.id);

      pendingBroken.add(brokenItem);
    }

    return pendingBroken;
  }

  Future getOldDamageItem() async {
    List<BrokenItem> pendingBroken = [];
    List<DamageModel> out = await OfficeClerkService().getOldDamageItem();
    if (out == null) {
      return pendingBroken;
    }
    for (var oneB in out) {
      BrokenItem brokenItem = new BrokenItem(
          category: oneB.categoryCategoryName,
          closeDate: oneB.closeDate,
          image: oneB.imageUrl,
          issue: oneB.reason,
          damageId: oneB.damageId.toString(),
          itemId: oneB.id.toString(),
          model: oneB.modelModelName,
          openDate: oneB.openDate,
          status: oneB.status,
          storeCode: oneB.id);

      // print("tttt ${oneB.closeDate.toString()}");

      pendingBroken.add(brokenItem);
    }

    return pendingBroken;
  }

  Future markSendToRepair(String id) async {
    var out = await OfficeClerkService().markSendToRepair(id);
    return out;
  }

  Future markAsFinished(String id, String itemID) async {
    var out = await OfficeClerkService().markFinishedRepair(id, itemID);
    return out;
  }
}
