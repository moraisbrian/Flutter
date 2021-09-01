import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  CepStore? cepStore = CepStore();

  ObservableList images = ObservableList();

  @observable
  Category? category;

  @observable
  bool? hidePhone = false;

  @observable
  String title = '';

  @observable
  String description = '';

  @observable
  String priceText = '';

  @action
  void setCategory(Category value) => category = value;

  @action
  void setHidePhone(bool? value) => hidePhone = value;

  @action
  void setTitle(String value) => title = value;

  @action
  void setDescription(String value) => description = value;

  @action
  void setPrice(String value) => priceText = value;

  @computed
  bool get imagesValid => images.isNotEmpty;

  @computed
  String? get imagesError {
    if (imagesValid)
      return null;
    else
      return 'Insira imagens';
  }

  @computed
  bool get titleValid => title.length >= 6;

  @computed
  String? get titleError {
    if (titleValid)
      return null;
    else if (title.isEmpty)
      return 'Título obrigatório';
    else
      return 'Título muito curto';
  }

  @computed
  bool get descriptionValid => description.length >= 10;

  @computed
  String? get descriptionError {
    if (descriptionValid)
      return null;
    else if (description.isEmpty)
      return 'Descrição obrigatória';
    else
      return 'Descrição muito curta';
  }

  @computed
  bool get categoryValid => category != null;

  @computed
  String? get categoryError {
    if (categoryValid)
      return null;
    else
      return 'Campo obrigatório';
  }

  @computed
  Address? get address => cepStore?.address;

  @computed
  bool get addressValid => address != null;

  @computed
  String? get addressError {
    if (addressValid)
      return null;
    else
      return 'Campo obrigatório';
  }

  @computed
  num? get price {
    if (priceText.contains(',')) {
      var parse = num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), ''));
      if (parse != null)
        return parse / 100;
      else
        return null;
    } else {
      return num.tryParse(priceText);
    }
  }

  @computed
  bool get priceValid => price != null && price! <= 9999999;

  @computed
  String? get priceError {
    if (priceValid)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Preço inválido';
  }

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  void send() {}
}
