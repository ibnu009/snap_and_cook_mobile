import 'package:get/get.dart';
import 'package:snap_and_cook_mobile/domain/use_case/utensils/utensil_use_case.dart';

import '../../../data/remote/models/utensil_model.dart';
import '../../base/base_view_model.dart';

class UtensilViewModel extends BaseViewModel {
  final _useCase = UtensilUseCase();

  RxList<Utensil> utensils = RxList();

  @override
  void onInit() {
    super.onInit();
    _fetchUtensils();
  }

  Future<void> _fetchUtensils() async {
    showLoadingContainer();
    utensils.value = await _useCase.fetchUtensils();
    hideLoadingContainer();
  }

  void onSelectUtensil(Utensil utensil, int index){
    if (utensil.isSelected == null || utensil.isSelected == 0){
      utensil.isSelected = 1;
    } else{
      utensil.isSelected = 0;
    }
    utensils[index] = utensil;
    utensils.refresh();
    _useCase.updateUtensil(utensil);
  }

}
