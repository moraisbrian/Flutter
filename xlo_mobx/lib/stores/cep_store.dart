import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/repositories/cep_repository.dart';

part 'cep_store.g.dart';

class CepStore = _CepStore with _$CepStore;

abstract class _CepStore with Store {
  _CepStore() {
    autorun((_) {
      if (clearCep.length != 8) {
        _reset();
      } else {
        _searchCep();
      }
    });
  }

  @observable
  String cep = '';

  @observable
  Address? address;

  @observable
  String error = '';

  @observable
  bool loading = false;

  @action
  void setCep(String value) => cep = value;

  @action
  Future<void> _searchCep() async {
    loading = true;
    try {
      address = await CepRepository().getAddressFromApi(clearCep);
      error = '';
    } catch (e) {
      error = e.toString();
      address = null;
    }
    loading = false;
  }

  @action
  void _reset() {
    address = null;
    error = '';
  }

  @computed
  String get clearCep => cep.replaceAll(RegExp('[^0-9]'), '');
}
