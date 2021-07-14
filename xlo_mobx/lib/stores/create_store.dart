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

  @observable
  String title = '';

  @observable
  String description = '';

  @action
  void setCategory(Category value) => category = value;

  @action
  void setHidePhone(bool? value) => hidePhone = value;

  @action
  void setTitle(String value) => title = value;

  @action
  void setDescription(String value) => description = value;

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
}
