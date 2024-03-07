import 'package:snap_and_cook_mobile/data/local/utensils_contract.dart';
import 'package:snap_and_cook_mobile/domain/use_case/utensils/utensil_resource.dart';

import '../../../data/remote/models/utensil_model.dart';
import 'utensil_interface.dart';

class UtensilUseCase implements UtensilInterface {
  final _dbContract = UtensilContract();

  @override
  Future<List<Utensil>> fetchUtensils() async {
    List<Utensil> utensils = await _dbContract.getUtensils();
    if (utensils.isEmpty){
      _dbContract.insertAllUtensil(utensilResource);
      return utensilResource;
    }

    return utensils;
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
