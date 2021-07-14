import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @observable
  Category? category;

  @observable
  bool? hidePhone = false;

  @action
  void setCategory(Category value) => category = value;

  @action
  void setHidePhone(bool? value) => hidePhone = value;

  @computed
  bool get imagesValid => images.isNotEmpty;

  @computed
  String? get imagesError {
    if (imagesValid)
      return null;
    else
      return 'Insira imagens';
  }
}
