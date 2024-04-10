class ApiNetwork{

  // static const BASE_URL = "https://mapd726-api-1.onrender.com";
  static const BASE_URL = "https://mapd726-api-2.onrender.com";

  static const LOGIN_URL = BASE_URL+"/login";
  static const REGISTER_URL = BASE_URL+"/register";
  static const USER_URL = BASE_URL+"/user";
  static const PRODUCT_BY_CATEGORY = BASE_URL+"/products/brand";
  static const PRODUCT_DETAIL_BY_ID = BASE_URL+"/products";

  static const ADD_PRODUCT = BASE_URL+"/products";

  static const ADD_ITEMS_IN_CART = BASE_URL+"/cartitems";
  static const GET_ALL_CART_ITEMS = BASE_URL+"/cart";

  static const CHECKOUT = BASE_URL+"/checkout";
  static const CUSTOMER_ORDER_LIST = BASE_URL+"/orderList";

  static const ADMIN_ALL_ORDERS = BASE_URL+"/orders";
  static const ADMIN_ALL_ORDERS_STATUS_CHANGE = BASE_URL+"/orderStatus";

  static const ALL_USERS = BASE_URL+"/users";
  static const ALL_USER = BASE_URL+"/user";

  static const ALL_NUMBERS = BASE_URL+"/reporting/numbers";
  static const ALL_FIVE_PRODUCTS = BASE_URL+"/reporting/topproducts";
  static const ALL_VALUES = BASE_URL+"/reporting/values";


}