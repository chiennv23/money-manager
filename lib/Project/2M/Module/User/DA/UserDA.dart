import 'package:coresystem/Core/CacheService.dart';
import 'package:coresystem/Project/2M/LocalDatabase/Models/user_info.dart';

class UserControl{
  Future<UserItem> getUserInfo(int id) async{
    var rs = await CacheService.getByKey<UserItem>(id);
    return rs;
  }

  Future<void> addOrEdit(UserItem userItem)async {
    await CacheService.add<UserItem>(userItem.iD, userItem);
  }

  Future<void> deleteUser(UserItem userItem)async {
    await CacheService.delete<UserItem>(userItem.iD);
  }
}
