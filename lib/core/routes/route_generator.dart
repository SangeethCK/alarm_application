// import 'package:flutter/material.dart';
// import 'package:tg_ecom_app/core/routes/routes.dart';
// import 'package:tg_ecom_app/domain/models/address/response/address_model.dart';
// import 'package:tg_ecom_app/domain/models/cart/response/cart_model.dart';
// import 'package:tg_ecom_app/domain/models/category/category_model.dart';
// import 'package:tg_ecom_app/domain/models/customer/response/customer_model.dart';
// import 'package:tg_ecom_app/domain/models/order/response/order_model.dart';
// import 'package:tg_ecom_app/domain/models/product_variant/product_variant_model.dart';
// import 'package:tg_ecom_app/presentation/screens/about_us/about_us.dart';
// import 'package:tg_ecom_app/presentation/screens/account/screen_account.dart';
// import 'package:tg_ecom_app/presentation/screens/address/pages/screen_add_address.dart';
// import 'package:tg_ecom_app/presentation/screens/address/pages/screen_address_details.dart';
// import 'package:tg_ecom_app/presentation/screens/address/pages/screen_addresses.dart';
// import 'package:tg_ecom_app/presentation/screens/address/pages/screen_edit_address.dart';
// import 'package:tg_ecom_app/presentation/screens/address/pages/screen_select_addresses.dart';
// import 'package:tg_ecom_app/presentation/screens/auth/sign-in/screen_sign_in.dart';
// import 'package:tg_ecom_app/presentation/screens/auth/sign-up/screen_sign_up.dart';
// import 'package:tg_ecom_app/presentation/screens/auth/verification/screen_verification.dart';
// import 'package:tg_ecom_app/presentation/screens/cart/screen_cart.dart';
// import 'package:tg_ecom_app/presentation/screens/category/screen_category.dart';
// import 'package:tg_ecom_app/presentation/screens/checkout/screen_checkout.dart';
// import 'package:tg_ecom_app/presentation/screens/contact_us/screen_contact_us.dart';
// import 'package:tg_ecom_app/presentation/screens/home/screen_home.dart';
// import 'package:tg_ecom_app/presentation/screens/main/screen_main.dart';
// import 'package:tg_ecom_app/presentation/screens/notifications/screen_notifications.dart';
// import 'package:tg_ecom_app/presentation/screens/orders/pages/cancel_order.dart';
// import 'package:tg_ecom_app/presentation/screens/orders/pages/cancel_order_popup.dart';
// import 'package:tg_ecom_app/presentation/screens/orders/pages/screen_order_details.dart';
// import 'package:tg_ecom_app/presentation/screens/orders/pages/screen_orders.dart';
// import 'package:tg_ecom_app/presentation/screens/product/pages/screen_product_details.dart';
// import 'package:tg_ecom_app/presentation/screens/product/pages/screen_products.dart';
// import 'package:tg_ecom_app/presentation/screens/profile/screen_edit_profile.dart';
// import 'package:tg_ecom_app/presentation/screens/profile/screen_profile.dart';
// import 'package:tg_ecom_app/presentation/screens/result/screen_result.dart';
// import 'package:tg_ecom_app/presentation/screens/search/screen_search.dart';
// import 'package:tg_ecom_app/presentation/screens/splash/screen_splash.dart';
// import 'package:tg_ecom_app/presentation/screens/terms/screen_terms.dart';
// import 'package:tg_ecom_app/presentation/screens/view_all/screen_view_all.dart';
// import 'package:tg_ecom_app/presentation/widgets/appbar/appbar.dart';

// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings routeSettings) {
//     final Object? args = routeSettings.arguments;

//     switch (routeSettings.name) {
//       case routeRoot:
//         return MaterialPageRoute(builder: (_) => const ScreenSplash());

//       case routeSignUp:
//         return MaterialPageRoute(builder: (_) => const ScreenSignUp());

//       case routeSignIn:
//         return MaterialPageRoute(builder: (_) => const ScreenSignIn());

//       case routeVerification:
//         if (args is Map) {
//           return MaterialPageRoute(
//             builder: (_) => ScreenVerification(
//               verificationId: args['verification_id'],
//               resendToken: args['resend_token'],
//               username: args['username'],
//               authType: args['authType'],
//             ),
//           );
//         }
//         return _errorRoute(argsError: true);

//       case routeMain:
//         return MaterialPageRoute(builder: (_) => const ScreenMain());

//       case routeHome:
//         return MaterialPageRoute(builder: (_) => const ScreenHome());

//       case routeSearch:
//         if (args is List<ProductVariantModel>) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenSearch(latestProduct: args));
//         }
//         return _errorRoute(argsError: true);

//       case routeCategory:
//         return MaterialPageRoute(builder: (_) => const ScreenCategory());

//       case routeAccount:
//         return MaterialPageRoute(builder: (_) => const ScreenAccount());
//       case routeTerms:
//         return MaterialPageRoute(builder: (_) => const ScreenTerms());
//       case routeAboutUs:
//         return MaterialPageRoute(builder: (_) => const ScreenAboutUs());
//       case routeContactUs:
//         return MaterialPageRoute(builder: (_) => const ScreenContactUs());

//       case routeCart:
//         return MaterialPageRoute(builder: (_) => const ScreenCart());

//       case routeOrderPop:
//         if (args is OrderModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenOrderPop(orderId: args));
//         }
//         return _errorRoute(argsError: true);
//       case routeOrderCancel:
//         if (args is OrderModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenCancelOrder(order: args));
//         }
//         return _errorRoute(argsError: true);
//       case routeProducts:
//         if (args is CategoryModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenProducts(category: args));
//         }
//         return _errorRoute(argsError: true);

//       case routeProductDetails:
//         if (args is ProductVariantModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenProductDetails(variant: args));
//         }
//         return _errorRoute(argsError: true);

//       case routeViewAll:
//         if (args is Map) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenViewAll(
//                     title: args['title'],
//                     products: args['products'],
//                     productsGroupsId: args['productsGroupsId'],
//                   ));
//         }
//         return _errorRoute(argsError: true);

//       case routeCheckout:
//         if (args is List<CartModel>) {
//           return MaterialPageRoute(builder: (_) => ScreenCheckout(carts: args));
//         }
//         return _errorRoute(argsError: true);

//       case routeAddresses:
//         return MaterialPageRoute(builder: (_) => const ScreenAddresses());

//       case routeSelectAddress:
//         return MaterialPageRoute(builder: (_) => const ScreenSelectAddress());

//       case routeAddressDetails:
//         return MaterialPageRoute(builder: (_) => const ScreenAddressDetails());

//       case routeAddAddress:
//         return MaterialPageRoute(builder: (_) => const ScreenAddAddress());

//       case routeEditAddress:
//         if (args is AddressModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenEditAddress(address: args));
//         }
//         return _errorRoute(argsError: true);

//       case routeResult:
//         return MaterialPageRoute(
//             builder: (_) => const ScreenResult(state: 'Success'));

//       case routeNotifications:
//         return MaterialPageRoute(builder: (_) => const ScreenNotifications());

//       case routeOrders:
//         return MaterialPageRoute(builder: (_) => const ScreenOrders());

//       case routeOrderDetails:
//         if (args is OrderModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenOrderDetails(order: args));
//         }
//         return _errorRoute(argsError: true);

//       case routeProfile:
//         return MaterialPageRoute(builder: (_) => const ScreenProfile());

//       case routeEditProfile:
//         if (args is CustomerModel) {
//           return MaterialPageRoute(
//               builder: (_) => ScreenEditProfile(customer: args));
//         }
//         return _errorRoute(argsError: true);

//       default:
//         return _errorRoute();
//     }
//   }

//   static Route<dynamic> _errorRoute({String? error, bool argsError = false}) {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: const AppbarWidget(
//           title: 'Error',
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Text(
//             error ?? '${argsError ? 'Arguments' : 'Navitation'} Error',
//             style: const TextStyle(
//                 fontWeight: FontWeight.w600, color: Colors.black54),
//           ),
//         ),
//       ),
//     );
//   }
// }
