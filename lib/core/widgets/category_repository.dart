import 'package:dio/dio.dart';
import '../../features/article/data/models/category/category.dart';
import '../../features/article/domain/data/singletons/dio_settings.dart';
import '../../features/article/domain/data/singletons/storage.dart';
import '../../features/article/domain/data/utils/custom_exception.dart';
import '../injector/injector.dart';
import '../models/category_single/category_single.dart';

class CategoryRepository {
  final _dio = serviceLocator<DioSettings>().dio;

  Future<List<CategoryResponse>> getCategories() async {
    try {
      final response = await _dio.get(
        '/category/list',
        options: StorageRepository.getString('token').isNotEmpty
            ? Options(
                headers: {
                  'Authorization':
                      'Bearer ${StorageRepository.getString('token')}'
                },
              )
            : null,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          return (response.data['data'] as List)
              .map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } catch (e) {
          throw const CustomException(
            message: 'Ma`lumot qabul qilishda xatolik yuz berdi',
            code: '141',
          );
        }
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      throw CustomException(
        message: '$e',
        code: '141',
      );
    }
  }

  Future<CategorySingle> getCategoryArticles({required String slug}) async {
    try {
      final response = await _dio.get(
        '/category/$slug',
        options: StorageRepository.getString('token').isNotEmpty
            ? Options(
                headers: {
                  'Authorization':
                      'Bearer ${StorageRepository.getString('token')}'
                },
              )
            : null,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        try {
          return CategorySingle.fromJson(
            response.data['data'] as Map<String, dynamic>,
          );
        } catch (e) {
          throw const CustomException(
            message: 'Ma`lumot qabul qilishda xatolik yuz berdi',
            code: '141',
          );
        }
      } else {
        throw CustomException(
          message: '${response.data}',
          code: '${response.statusCode}',
        );
      }
    } on Exception catch (e) {
      throw CustomException(
        message: '$e',
        code: '141',
      );
    }
  }
}
