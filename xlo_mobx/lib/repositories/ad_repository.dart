import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class AdRepository {
  Future<void> save(Ad ad) async {
    final parseImages = await saveImages(ad.images);
    final parseUser = ParseUser('', '', '')..set(keyUserId, ad.user!.id);
    final adObject = ParseObject(keyAdTable);
    final parseAcl = ParseACL(owner: parseUser);

    parseAcl.setPublicReadAccess(allowed: true);
    parseAcl.setPublicWriteAccess(allowed: false);
    adObject.setACL(parseAcl);

    adObject.set<String>(keyAdTitle, ad.title);
    adObject.set<String>(keyAdDescription, ad.description);
    adObject.set<bool?>(keyAdHidePhone, ad.hidePhone);
    adObject.set<num?>(keyAdPrice, ad.price);
    adObject.set<int>(keyAdStatus, ad.status.index);

    adObject.set<String?>(keyAdDistrict, ad.address?.district);
    adObject.set<String?>(keyAdCity, ad.address?.city?.name);
    adObject.set<String?>(keyAdFederativeUnit, ad.address?.uf?.initials);
    adObject.set<String?>(keyAdPostaCode, ad.address?.cep);

    adObject.set<List<ParseFile>>(keyAdImages, parseImages);

    adObject.set<ParseUser>(keyAdOwner, parseUser);

    adObject.set<ParseObject>(keyAdCategory,
        ParseObject(keyCategoryTable)..set(keyCategoryId, ad.category!.id));

    final response = await adObject.save();
    print(response.success);
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];
    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error!.code));
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error('Falha ao salvar imagens');
    }
  }
}
