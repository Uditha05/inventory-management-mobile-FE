import 'package:flutter_test/flutter_test.dart';

import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/controller/office_clerk_controller.dart';
import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/model/office_clerk_related/repairModel.dart';
import 'package:inventory_management/service/office_clerk_service.dart';
import 'package:mockito/mockito.dart';

class MockOfficeClerkService extends Mock implements OfficeClerkService {
  @override
  Future getNewDamageItems() async {
    DamageModel damageModel = new DamageModel(
      id: "1",
      imageUrl: "1",
      damageModelCategoryId: 1,
      damageModelModelId: 1,
      damageModelLabId: 1,
      availability: 1,
      status: "1",
      addDate: DateTime.now(),
      categoryId: 1,
      modelId: 1,
      labId: 1,
      categoryCategoryName: "1",
      labLabName: "1",
      modelModelName: "1",
      reason: "1",
      openDate: DateTime.now(),
      damageId: 1,
      closeDate: null,
    );
    List<DamageModel> responseModel = [];
    responseModel.add(damageModel);
    return responseModel;
  }

  @override
  Future getOldDamageItem() async {
    DamageModel damageModel = new DamageModel(
      id: "1",
      imageUrl: "1",
      damageModelCategoryId: 1,
      damageModelModelId: 1,
      damageModelLabId: 1,
      availability: 1,
      status: "1",
      addDate: DateTime.now(),
      categoryId: 1,
      modelId: 1,
      labId: 1,
      categoryCategoryName: "1",
      labLabName: "1",
      modelModelName: "1",
      reason: "1",
      openDate: DateTime.now(),
      damageId: 1,
      closeDate: DateTime.now(),
    );
    List<DamageModel> responseModel = [];
    responseModel.add(damageModel);
    return responseModel;
  }

  @override
  Future getPendingRepairItems() async {
    DamageModel damageModel = new DamageModel(
      id: "1",
      imageUrl: "1",
      damageModelCategoryId: 1,
      damageModelModelId: 1,
      damageModelLabId: 1,
      availability: 1,
      status: "1",
      addDate: DateTime.now(),
      categoryId: 1,
      modelId: 1,
      labId: 1,
      categoryCategoryName: "1",
      labLabName: "1",
      modelModelName: "1",
      reason: "1",
      openDate: DateTime.now(),
      damageId: 1,
      closeDate: DateTime.now(),
    );
    List<DamageModel> responseModel = [];
    responseModel.add(damageModel);
    return responseModel;
  }

  @override
  Future markSendToRepair(String id) async {
    if (id == "1-2-3-4") {
      return "pass";
    } else {
      return null;
    }
  }

  @override
  Future markFinishedRepair(String id, String itemId) async {
    if (id == "1" && itemId == "1-2-3-4") {
      return "pass";
    } else {
      return null;
    }
  }
}

void main() {
  group("offce_clerk_controller_tests: ", () {
    test("Get New Damage Request", () async {
      MockOfficeClerkService mockService = MockOfficeClerkService();

      OfficeClerkController officeClerkController =
          OfficeClerkController.internal(mockService);
      var out = await officeClerkController.getNewDamages();

      expect(out, isA<List<BrokenItem>>());
    });

    test("Get Under Repair Items", () async {
      MockOfficeClerkService mockService = MockOfficeClerkService();

      OfficeClerkController officeClerkController =
          OfficeClerkController.internal(mockService);
      var out = await officeClerkController.getPendingRepair();

      expect(out, isA<List<BrokenItem>>());
    });

    test("Get Old Damage Request", () async {
      MockOfficeClerkService mockService = MockOfficeClerkService();

      OfficeClerkController officeClerkController =
          OfficeClerkController.internal(mockService);
      var out = await officeClerkController.getOldDamageItem();

      expect(out, isA<List<BrokenItem>>());
    });

    test("Mark as send to repair", () async {
      MockOfficeClerkService mockService = MockOfficeClerkService();

      OfficeClerkController officeClerkController =
          OfficeClerkController.internal(mockService);
      var out = await officeClerkController.markSendToRepair("1-2-3-4");

      expect(out, "pass");
    });

    test("Mark as finish repair", () async {
      MockOfficeClerkService mockService = MockOfficeClerkService();

      OfficeClerkController officeClerkController =
          OfficeClerkController.internal(mockService);
      var out = await officeClerkController.markAsFinished("1", "1-2-3-4");

      expect(out, "pass");
    });
  });
}
