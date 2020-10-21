// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://invosa.justprintup.com/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<ModelReturnLogin> postLogin(param) async {
    ArgumentError.checkNotNull(param, 'param');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('Auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelReturnLogin.fromJson(_result.data);
    return value;
  }

  @override
  Future<ModelReturnLogin> postNewRegister(param) async {
    ArgumentError.checkNotNull(param, 'param');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(param?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('Auth/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelReturnLogin.fromJson(_result.data);
    return value;
  }

  @override
  Future<ModelGeneralReturn> postUpdateOrPassword(prefToken, param) async {
    ArgumentError.checkNotNull(prefToken, 'prefToken');
    ArgumentError.checkNotNull(param, 'param');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': prefToken};
    final _data = <String, dynamic>{};
    _data.addAll(param?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('Auth/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelGeneralReturn.fromJson(_result.data);
    return value;
  }

  @override
  Future<ModelGeneralReturn> getSetting(prefToken) async {
    ArgumentError.checkNotNull(prefToken, 'prefToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': prefToken};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('Auth/setting',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelGeneralReturn.fromJson(_result.data);
    return value;
  }

  @override
  Future<ModelAbsensi> getListAbensi(prefToken) async {
    ArgumentError.checkNotNull(prefToken, 'prefToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': prefToken};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('Auth/listabsen',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelAbsensi.fromJson(_result.data);
    return value;
  }

  @override
  Future<ModelGeneralReturn> postAbsen(prefToken, param) async {
    ArgumentError.checkNotNull(prefToken, 'prefToken');
    ArgumentError.checkNotNull(param, 'param');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': prefToken};
    final _data = <String, dynamic>{};
    _data.addAll(param?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('Auth/absen',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelGeneralReturn.fromJson(_result.data);
    return value;
  }

  @override
  Future<ModelHome> getHome(prefToken) async {
    ArgumentError.checkNotNull(prefToken, 'prefToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'token': prefToken};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('Auth/home',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ModelHome.fromJson(_result.data);
    return value;
  }
}
