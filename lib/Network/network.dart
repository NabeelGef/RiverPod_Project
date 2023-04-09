import 'package:dio/dio.dart';
import 'package:riverpod_project/Constant/api.dart';
import 'package:riverpod_project/Model/cart.dart';
import 'package:riverpod_project/Model/error.dart';
import 'package:riverpod_project/Model/usermodel.dart';

import '../Model/message.dart';
import '../Model/productmodel.dart';

class NetworkCreator {
  CartItem cartItem = CartItem();
  Future<Product> getAllProduct(int per_page) async {
    Dio dio = Dio();
    Product product = Product();
    Response response = await dio.get("${API.BaseUrl}${API.product}",
        queryParameters: {'perpage': per_page});
    if (response.statusCode == 200) {
      product = Product.fromJson(response.data);
    }
    return product;
  }

  Future<Object?> registeration(User user) async {
    Users users = Users();
    ErrorData error = ErrorData();
    Dio dio = Dio();
    // Response? response;
    // try {
    Response response = await dio.post("${API.BaseUrl}${API.register}",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {"Accept": "application/json"},
        ),
        queryParameters: {
          'email': user.email,
          'name': user.name,
          'password': user.password,
          'password_confirmation': user.confirmpassword
        });
    if (response.statusCode == 200) {
      users = Users.fromJson(response.data);
      return users;
    } else {
      error = ErrorData.fromJson(response.data);
      return error;
    }

    // } catch (error) {
    //   users.error = res;
    //   print(error);
    //   return users;
    // }
  }

  Future<Message> logout(String token) async {
    Dio dio = Dio();
    Response response = await dio.post(
      "${API.BaseUrl}${API.logout}",
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    return Message.fromJson(response.data);
  }

  Future<Object?> logging(User user) async {
    Users users = Users();
    ErrorData error = ErrorData();
    Dio dio = Dio();
    // Response? response;
    // try {
    Response response = await dio.post("${API.BaseUrl}${API.login}",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {"Accept": "application/json"},
        ),
        queryParameters: {
          'email': user.email,
          'password': user.password,
        });
    if (response.statusCode == 200) {
      users = Users.fromJson(response.data);
      return users;
    } else {
      error = ErrorData.fromJson(response.data);
      return error;
    }
  }

  Future<Detail> getDetailProduct(int id) async {
    Dio dio = Dio();
    Detail data = Detail();
    Response response = await dio.get("${API.BaseUrl}${API.product}/$id");
    print("DATA : ${response.data}");
    if (response.statusCode == 200) {
      data = Detail.fromJson(response.data);
    }
    return data;
  }

  Future<List<Detail>> getDetailProductCart(String token) async {
    cartItem = await getallCart(token);
    Dio dio = Dio();
    List<Detail> data = [];
    //print("HELOOOOOOOOOOOOOO ${cartItem.cart!.items}");
    for (int i = 0; i < (cartItem.cart!.products!.length); i++) {
      int id = cartItem.cart!.products![i].productId!;
      Response response = await dio.get("${API.BaseUrl}${API.product}/$id");
      if (response.statusCode == 200) {
        data.add(Detail.fromJson(response.data));
      }
    }
    return data;
  }

  Future<CartItem> getallCart(String token) async {
    Dio dio = Dio();
    CartItem cartItem = CartItem();
    Response response = await dio.get(
      "${API.BaseUrl}${API.cart}",
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    if (response.statusCode == 200) {
      cartItem = CartItem.fromJson(response.data);
    }
    return cartItem;
  }

  Future<CartItem> addCart(String token, int id, int quantity) async {
    Dio dio = Dio();
    cartItem = CartItem();
    Response response = await dio.put(
      "${API.BaseUrl}${API.addCart}",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
      queryParameters: {
        "product_id": id,
        "quantity": quantity,
      },
    );
    if (response.statusCode == 200) {
      cartItem = CartItem.fromJson(response.data);
    }
    return cartItem;
  }

  Object deleteCart(int id, String token) async {
    Dio dio = Dio();
    Response response = await dio.delete("${API.BaseUrl}${API.addCart}",
        queryParameters: {
          "product_id": id,
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }));
    if (response.statusCode == 200) {
      return CartItem.fromJson(response.data);
    } else {
      return Message.fromJson(response.data);
    }
  }
}




// class NetworkOptions {
//   void Function(int, int)? onReceiveProgress;

//   NetworkOptions({this.onReceiveProgress});
// }

// class NetworkCreator {
//   static var shared = NetworkCreator();
//   Dio _client = Dio();

//   Future<Response> request(
//       {required BaseClientGenerator route, NetworkOptions? options}) {
//     return _client.fetch(RequestOptions(
//         baseUrl: route.baseURL,
//         method: route.method,
//         path: route.path,
//         queryParameters: route.queryParameters,
//         data: route.body,
//         sendTimeout: route.sendTimeout,
//         receiveTimeout: route.sendTimeout,
//         onReceiveProgress: options?.onReceiveProgress,
//         validateStatus: (statusCode) => (statusCode! >= HttpStatus.ok &&
//             statusCode <= HttpStatus.multipleChoices)));
//   }
// }

// class NetworkDecoder {
//   static var shared = NetworkDecoder();

//   K decode<T extends BaseNetworkModel, K>(
//       {required Response<dynamic> response, required T responseType}) {
//     try {
//       if (response.data is List) {
//         var list = response.data as List;
//         var dataList = List<T>.from(
//             list.map((item) => responseType.fromJson(item)).toList()) as K;
//         return dataList;
//       } else {
//         var data = responseType.fromJson(response.data) as K;
//         return data;
//       }
//     } on TypeError catch (e) {
//       throw e;
//     }
//   }
// }

// class NetworkExecuter {
//   static var shared = NetworkExecuter();

//   bool debugMode = true;

//   Future<Result<K, NetworkError>> execute<T extends BaseNetworkModel, K>(
//       {required BaseClientGenerator route,
//       required T responseType,
//       NetworkOptions? options}) async {
//     if (debugMode) print(route);

//     // Check Network Connectivity
//     if (await NetworkConnectivity.status) {
//       try {
//         var response =
//             await NetworkCreator.shared.request(route: route, options: options);
//         var data = NetworkDecoding.shared
//             .decode<T, K>(response: response, responseType: responseType);
//         return Result.success(data);

//         // NETWORK ERROR
//       } on DioError catch (diorError) {
//         if (debugMode)
//           print("$route => ${NetworkError.request(error: diorError)}");
//         return Result.failure(NetworkError.request(error: diorError));

//         // TYPE ERROR
//       } on TypeError catch (e) {
//         if (debugMode)
//           print("$route => ${NetworkError.type(error: e.toString())}");
//         return Result.failure(NetworkError.type(error: e.toString()));
//       }

//       // No Internet Connection
//     } else {
//       if (debugMode)
//         print(NetworkError.connectivity(message: 'No Internet Connection'));
//       return Result.failure(
//           NetworkError.connectivity(message: 'No Internet Connection'));
//     }
//   }
// }

// @freezed
// class Result<T, E extends Exception> with _$Result<T, E> {
//   const factory Result.success(T data) = _Success;
//   const factory Result.failure(E error) = _Failure;
// }

// @freezed
// class NetworkError with _$NetworkError implements Exception {
//   const NetworkError._() : super();

//   const factory NetworkError.request({required DioError error}) =
//       _ResponseError;
//   const factory NetworkError.type({String? error}) = _DecodingError;
//   const factory NetworkError.connectivity({String? message}) = _Connectivity;

//   String? get localizedErrorMessage {
//     return this.when<String?>(
//       type: (error) => error,
//       connectivity: (message) => message,
//       request: (DioError error) => error.message,
//     );
//   }
// }

// @freezed
// class PlaceHolderClient extends BaseClientGenerator with _$PlaceHolderClient {
//   // ROTA TANIMLAMALARI
//   const PlaceHolderClient._() : super();
//   const factory PlaceHolderClient.posts() = _Posts;
//   const factory PlaceHolderClient.users() = _Users;

//   @override
//   String get baseURL => "https://jsonplaceholder.typicode.com/";

//   @override
//   Map<String, dynamic> get header => {"Content-Type": "application/json"};

//   @override
//   String get path {
//     return this.when<String>(posts: () => 'posts/', users: () => 'users/');
//   }

//   @override
//   String get method {
//     return this.maybeWhen<String>(
//       orElse: () => 'GET', // AKSİ BELİRTİLMEDİKÇE İSTEKLER GET OLARAK GİDECEK.
//     );
//   }

//   @override
//   Map<String, dynamic>? get body {
//     return this.maybeWhen(orElse: () {
//       return null; // AKSİ BELİRTİLMEDİKÇE BODY NULL GİDECEK.
//     });
//   }

//   @override
//   Map<String, dynamic>? get queryParameters {
//     return this.maybeWhen(
//       orElse: () {
//         return null; // AKSİ BELİRTİLMEDİKÇE QUERY NULL GİDECEK.
//       },
//     );
//   }
// }
