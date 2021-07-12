import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/uf.dart';

class IbgeRepository {
  Future<List<Uf>?> getUfListFromApi() async {
    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endpoint);

      final ufList = response.data?.map<Uf>((e) => Uf.fromJson(e)).toList()
        ?..sort(
          (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter lista de estados');
    }
  }

  void getCityListFromApi() {}
}
