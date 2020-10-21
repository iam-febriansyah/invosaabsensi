import 'package:absensi/api/base_url.dart';
import 'package:absensi/models/auth/cls_post_login.dart';
import 'package:absensi/models/auth/cls_post_register.dart';
import 'package:absensi/models/auth/cls_return_login.dart';
import 'package:absensi/models/cls_general_return.dart';
import 'package:absensi/models/menu/cls_absen.dart';
import 'package:absensi/models/menu/cls_menu_home.dart';
import 'package:absensi/models/menu/cls_post_absen.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'service.g.dart';

RestClient getClient({String header}) {
  final dio = Dio();
  // dio.options.headers["Content-Type"] =
  //     header == null || header.isEmpty ? "application/json" : header;
  dio.options.connectTimeout = BaseUrl.connectTimeout;
  RestClient client = RestClient(dio);
  return client;
}

@RestApi(baseUrl: BaseUrl.MainUrls)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @POST("Auth")
  Future<ModelReturnLogin> postLogin(@Body() ModelPostLogin param);

  @POST("Auth/register")
  Future<ModelReturnLogin> postNewRegister(
      @Body() ModelPostEditRegisterPassword param);

  @POST("Auth/register")
  Future<ModelGeneralReturn> postUpdateOrPassword(
      @Query("token") String prefToken,
      @Body() ModelPostEditRegisterPassword param);

  @GET("Auth/setting")
  Future<ModelGeneralReturn> getSetting(@Query("token") String prefToken);

  @GET("Auth/listabsen")
  Future<ModelAbsensi> getListAbensi(@Query("token") String prefToken);

  @POST("Auth/absen")
  Future<ModelGeneralReturn> postAbsen(
      @Query("token") String prefToken, @Body() ModelPostAbsen param);

  @GET("Auth/home")
  Future<ModelHome> getHome(@Query("token") String prefToken);
}
