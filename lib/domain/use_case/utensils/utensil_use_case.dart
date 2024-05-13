import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/data/local/utensils_contract.dart';
import 'package:snap_and_cook_mobile/data/remote/services/utensil_service.dart';
import 'package:snap_and_cook_mobile/domain/use_case/utensils/utensil_resource.dart';

import '../../../data/remote/models/utensil_model.dart';
import 'utensil_interface.dart';

class UtensilUseCase implements UtensilInterface {
  final _dbContract = UtensilContract();
  final _utensilService = Get.find<UtensilServices>();

  @override
  Future<List<Utensil>> fetchUtensils() async {
    try{
      var response = await _utensilService.getAllUtensil(CancelToken());
      List<Utensil> utensils = await _dbContract.getUtensils();

      if (utensils.length == (response.data?.length ?? 0)){
        return utensils;
      }

      await _dbContract.deleteAllUtensil();
      await _dbContract.insertAllUtensil(response.data ?? []);
      utensils = await _dbContract.getUtensils();
      return utensils;
    } catch (e){
      return [];
    }
  }

  @override
  Future<void> updateUtensil(Utensil utensil) async {
   await _dbContract.updateUtensil(utensil);
  }

  @override
  Future<List<String>> fetchSelectedUtensils() async {
    List<String> utensils = await _dbContract.getSelectedUtensils();
    return utensils;

  }
}
