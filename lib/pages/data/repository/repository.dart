import 'dart:async';

import 'package:novel/pages/data/model/request/book_chapters_req.dart';
import 'package:novel/pages/data/net/dio_utils.dart';



class Repository {
  ///获取首页小说列表
  Future<Map> getCategories(queryParameters) async {
    return await DioUtils().request<String>(
      "/book/by-categories",
      queryParameters: queryParameters,
    );
  }

  ///获取小说详情
  Future<Map> getBookInfo(bookId) async {
    return await DioUtils().request<String>(
      "/book/$bookId",
    );
  }

  ///获取小说正版源
  Future<Map> getBookGenuineSource(queryParameters) async {
    return await DioUtils().request<String>(
      "/btoc",
      queryParameters: queryParameters,
    );
  }

  ///获取小说章节列表
  Future<Map> getBookChapters(bookId) async {
    return await DioUtils().request<String>(
      "/atoc/$bookId",
      queryParameters: BookChaptersReq("chapters").toJson(),
    );
  }



  ///关键字搜索返回小说列表
  Future<Map> getFuzzySearchBookList(queryParameters) async {
    return await DioUtils().request<String>(
      "/book/fuzzy-search",
      queryParameters: queryParameters,
    );
  }
}
