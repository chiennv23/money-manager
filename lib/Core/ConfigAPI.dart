//uat
// ignore_for_file: flutter_style_todos

class ConfigAPI {
  // static const String url_socketIO = 'http://iacv-io-uat.snow.com.vn/';
  // static const String urlImg = 'http://image-iacv-dev.snow.com.vn/'; // https
  // TODO DOMAIN
  // static const String url = 'http://10.14.104.5:9674/';//dev
  static const String url = 'http://10.15.119.63:8889/'; // UAT
  // static const String urlApi = 'https://uat.einvoice.fpt.com.vn/';
  // static const String urlImg = 'http://image-iacv-dev.snow.com.vn/'; // https
  static const String domain =
      'api-uat.einvoice.fpt.com.vn,api-uat.einvoice.fpt.com.vn';

  static const String urlPaymentTypes = 'api/cat/kache/paym';
  static const String urlMoneyTypes = 'api/cat/kache/currency';

  // API vnpost
  static const String urlLogin = '${ConfigAPI.url}api/auth/login';
  static const String registerAPI = '${ConfigAPI.url}api/auth/register';
  static const String addresssearch = '${ConfigAPI.url}v1/address-search/get';
  static const String finalallunit = '${ConfigAPI.url}api/auth/find-all-unit';
  static const String verify = '${ConfigAPI.url}api/auth/verify';
  static const String resendOtp = '${ConfigAPI.url}api/auth/resendOtp';

  static const String urlUpdateSession =
      '${ConfigAPI.url}bo/api/bo/session/updateSession/';
  static const String urlLogout =
      '${ConfigAPI.url}bo/api/bo/session/terminalCurrentSession/';
  static const String urlListPlaceofIssue =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/00000000000000000000000000000000/REGBR/MAD/C04';
  static const String urlValidateEmail =
      '${ConfigAPI.url}bo/api/bo/module/validateField/00000000000000000000000000000000/REGBR/MAD/EMAIL';
  static const String urlRegistor =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/00000000000000000000000000000000/REGBR/MAD';
  static const String urlValidateOldPassword =
      '${ConfigAPI.url}bo/api/bo/module/validateField/{SessionID}/02199/MAD/OLD_PASSWORD';
  static const String urlValidatePassword =
      '${ConfigAPI.url}bo/api/bo/module/validateField/{SessionID}/02199/MAD/PASSWORD';
  static const String urlValidateRePassword =
      '${ConfigAPI.url}bo/api/bo/module/validateField/{SessionID}/02199/MAD/REPASSWORD';

  static const String urlchangePassword =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/02199/MAD';

  static const String urlValidateEmailForRessPassword =
      '${ConfigAPI.url}bo/api/bo/module/validateField/00000000000000000000000000000000/FGTPW/MAD/EMAIL';
  static const String urlValidatePhoneForRessPassword =
      '${ConfigAPI.url}bo/api/bo/module/validateField/00000000000000000000000000000000/FGTPW/MAD/PHONE';

  static const String urlRessPassword =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/00000000000000000000000000000000/FGTPW/MAD';

  static const String urlAccountInfo =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/2197A/MAD';

  // dien
  static const String urlElectricityBillPayment =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/EL000/MAD';

  static const String urlElectricityLoadHanderEL000MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/EL000/MAD';
  static const String urlElectricityPemissionEL001MAD =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/EL001/MAD';

  static const String urlloadHandlerEL001MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/EL001/MAD';

  static const String urlElectricitySuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/EL001/MAD/C01';

  static const String urlElectricityConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/EL001/MAD';

  static const String urlElectricityBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/EL002/MAD';

// nước
  static const String urlWaterCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/WT000/MAD';

  static const String urlWaterLoadHanderWT000MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/WT000/MAD';
  static const String urlWaterCheckPemissionWT001MAD =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/WT001/MAD';
  static const String urlWaterLoadHandlerWT001MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/WT001/MAD';
  static const String urlWaterSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/WT001/MAD/C01';

  static const String urlWaterConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/WT001/MAD';
  static const String urlWaterBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/WT002/MAD';

  // truyen hinh
  static const String urlCableTvCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/TV000/MAD';
  static const String urlCableTvLoadHanderTV000MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/TV000/MAD';
  static const String urlCableTvCheckPemissionTV001MAD =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/TV001/MAD';
  static const String urlCableTvLoadHandlerTV001MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/TV001/MAD';
  static const String urlCableTvSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/TV001/MAD/C01';
  static const String urlCableTvConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/TV001/MAD';
  static const String urlCableTvBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/TV002/MAD';

  //internet
  static const String urlInternetCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/IN000/MAD';
  static const String urlInternetLoadHanderIN000MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/IN000/MAD';
  static const String urlInternetCheckPemissionIN001MAD =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/IN001/MAD';
  static const String urlInternetLoadHandlerIN001MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/IN001/MAD';
  static const String urlInternetSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/IN001/MAD/C01';
  static const String urlInternetConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/IN001/MAD';
  static const String urlInternetBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/IN002/MAD';

  //vay tien dung Consumer
  static const String urlConsumerCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/FI000/MAD';
  static const String urlConsumerLoadHanderFI000MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/FI000/MAD';
  static const String urlConsumerCheckPemissionFI001MAD =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/FI001/MAD';
  static const String urlConsumerLoadHandlerFI001MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/FI001/MAD';
  static const String urlConsumerSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/FI001/MAD/C01';
  static const String urlConsumerConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/FI001/MAD';
  static const String urlConsumerBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/FI002/MAD';

  //VNPT
  static const String urlVNPTCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/VN000/MAD';
  static const String urlVNPTLoadHanderVN000MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/VN000/MAD';
  static const String urlVNPTCheckPemissionVN001MAD =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/VN001/MAD';
  static const String urlVNPTLoadHandlerVN001MAD =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/VN001/MAD';
  static const String urlVNPTSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/VN001/MAD/C01';
  static const String urlVNPTConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/VN001/MAD';
  static const String urlVNPTBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/VN002/MAD';

  //The dt
  static const String urlPhoneCardCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/50353/MAD';
  static const String urlPhoneCardLoadHander000 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/50353/MAD';
  static const String urlPhoneCardSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2353Z/MAD/C03';
  static const String urlPhoneCardCardTypes =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2353Z/MAD/C04';
  static const String urlPhoneCardConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2353Z/MAD';
  static const String urlPhoneCardloadHandler001 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/2353A/MAD';
  static const String urlPhoneCardBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2353A/MAD';

// nap tien dien thoai
  static const String urlRechargePhoneCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/50351/MAD';
  static const String urlRechargePhoneLoadHander000 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/50351/MAD';
  static const String urlRechargePhoneGetPhoneNumberDetail =
      '${ConfigAPI.url}bo/api/bo/module/callbackQuery/{SessionID}/2351Z/MAD/C01';
  static const String urlRechargePhoneSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2351Z/MAD/C03';
  static const String urlRechargePhoneCardTypes =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2351Z/MAD/C04';
  static const String urlRechargePhoneConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2351Z/MAD';
  static const String urlRechargePhoneloadHandler001 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/2351A/MAD';
  static const String urlRechargePhoneBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2351A/MAD';

  // nap data dien thoai
  static const String urlRechargeDataCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/50357/MAD';
  static const String urlRechargeDataLoadHander000 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/50357/MAD';
  static const String urlRechargeDataGetPhoneNumberDetail =
      '${ConfigAPI.url}bo/api/bo/module/callbackQuery/{SessionID}/2357Z/MAD/C01';
  static const String urlRechargeDataSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2357Z/MAD/C03';
  static const String urlRechargeDataCardTypes =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2357Z/MAD/C04';
  static const String urlRechargeDataConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2357Z/MAD';
  static const String urlRechargeDataloadHandler001 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/2357A/MAD';
  static const String urlRechargeDataBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2357A/MAD';

  // nap the data
  static const String urlDataCardCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/50355/MAD';
  static const String urlDataCardLoadHander000 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/50355/MAD';
  // static const String urlDataCardGetPhoneNumberDetail =
  //     '${ConfigAPI.url}bo/api/bo/module/callbackQuery/{SessionID}/2355Z/MAD/C01';
  static const String urlDataCardSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2355Z/MAD/C03';
  static const String urlDataCardCardTypes =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/2355Z/MAD/C04';
  static const String urlDataCardaConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2355Z/MAD';
  static const String urlDataCardloadHandler001 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/2355A/MAD';
  static const String urlDataCardBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/2355A/MAD';

  // cuoc dien thoai tra sau, co dinh
  static const String urlPhoneBillCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/PH000/MAD';
  static const String urlPhoneBillLoadHander000 =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/PH000/MAD';
  static const String urlPhoneBillCheckPemission001 =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/PH001/MAD';
  static const String urlPhoneBillService =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/PH001/MAD/C00';
  static const String urlPhoneBillSuppliers =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/PH001/MAD/C01';
  static const String urlPhoneBillConfirm =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/PH001/MAD';
  static const String urlPhoneBillBeforPayment =
      '${ConfigAPI.url}bo/api/bo/maintain/execute/{SessionID}/PH002/MAD';

// transaction
  static const String urlTransactionCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/03168/MMN';
  static const String urlTransactionService =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/03168/MMN/C02';
  static const String urlTransactionStatus =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/03168/MMN/C07';
  static const String urlTransactionSupplier =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/02168/MVW/C03';
  static const String urlTransactionSearch =
      '${ConfigAPI.url}bo/api/bo/search/executeSearch/{SessionID}/03168/MMN';
  static const String urlTransactionSearchPageging =
      '${ConfigAPI.url}bo/api/bo/buffer/fetchPage/{SessionID}/03168/MMN';

  // hoa hong
  static const String urlCommissionCheckPemission =
      '${ConfigAPI.url}bo/api/bo/sa/checkRoleModule/{SessionID}/03168/MMN';
  static const String urlCommissionService =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/03165/MMN/B03';
  static const String urlCommissionAgent =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/03166/LKU/L04';
  static const String urlCommissionSupplier =
      '${ConfigAPI.url}bo/api/bo/module/getListSource/{SessionID}/02168/MVW/C03';
  static const String urlCommissionSearch =
      '${ConfigAPI.url}bo/api/bo/search/executeSearch/{SessionID}/03165/MMN';
  static const String urlCommissionSearchPageging =
      '${ConfigAPI.url}bo/api/bo/buffer/fetchPage/{SessionID}/03165/MMN';

  static const String urlCommissionConfirm =
      '${ConfigAPI.url}bo/api/bo/execute/execute/{SessionID}/1165B/MMN';
  static const String urlCommissionReject =
      '${ConfigAPI.url}bo/api/bo/execute/execute/{SessionID}/1165C/MMN';

  // payment
  static const String urlPayment =
      '${ConfigAPI.url}bo/api/bo/module/executeLoadHandler/{SessionID}/31001/MMN';

  static const String urlConfigSearch =
      '${ConfigAPI.url}bo/api/bo/sa/getSysVar/{SessionID}/SYSTEM/NUM_DAY_SEARCH';

  // // register
  // static const String urlRegister = '${ConfigAPI.urlApi}api/register/post';

  // // get agen
  // static const String urlAgen = '${ConfigAPI.urlApi}api/agen';

  // // reset pass
  // static const String urlReset = '${ConfigAPI.urlApi}api/ads/reset';
  // static const String urlUserUpdateInfo = '${ConfigAPI.urlApi}ous';

  // // lấy danh sách thành phố
  // static const String urlGetCity = '${ConfigAPI.urlApi}api/cat/kache/prov';

  // // lấy danh sách district
  // static String urlGetDistrict(String id) {
  //   return '${ConfigAPI.urlApi}api/cat/kache2/local/$id';
  // }

  // // lấy danh sách Tax district
  // static String urlGetTaxDistrict(String id) {
  //   return '${ConfigAPI.urlApi}api/cat/kache2/taxo/$id';
  // }

  // // DANH SÁCH CQT CẤP TRÊN
  // static String urlAllTaxDepartment = '${ConfigAPI.urlApi}api/cat/kache/taxo';

  // // Danh mục hàng hoá
  // static String urlGetCommomdity(
  //     {String start,
  //     String count,
  //     String name = '',
  //     String code = '',
  //     String unit = '',
  //     String vrn = '',
  //     String vat = '',
  //     String price = ''}) {
  //   return '${url}getAllGns?start=$start&count=$count&name=$name&price=$price&code=$code&unit=$unit&vrn=$vrn&vat=$vat';
  // }

  // // thêm, sửa, xoá hàng hoá
  // static const String urlActionCommomdity = '${url}catGns';

  // // Danh mục khách hàng
  // static String urlGetAllCustomer(
  //     {String start,
  //     String count,
  //     String name = '',
  //     String code = '',
  //     String taxc = '',
  //     String addr = '',
  //     String private}) {
  //   return '${ConfigAPI.url}getAllCus?start=$start&count=$count&name=$name&code=$code&taxc=$taxc&addr=$addr&private=$private';
  // }

  // // Thêm mới/Cập nhật thông tin KH Riêng
  // static const String urlCreateEditCustomer = '${ConfigAPI.urlApi}catCus';

  // // delete thông tin KH Riêng
  // static const String urlDelCustomer = '${ConfigAPI.urlApi}delCus';

  // // Danh mục loại tiền
  // static const String urlGetMoneyType =
  //     '${ConfigAPI.urlApi}api/cat/kache/currency';

  // // tạo hoá đơn
  // static const String urlCreateInvoice = '${ConfigAPI.urlApi}create-invoice';

  // // Ký duyệt hoá đơn
  // static const String urlApproveInvoice = '${ConfigAPI.urlApi}apprs';

  // // tra cứu hoá đơn
  // static const String urlSearchInvoice = '${ConfigAPI.urlApi}search-inv';
}

//prod

// class ConfigAPI {
//   static const String url_socketIO = 'http://iacv-io.snow.com.vn/';
//   static const String urlImg = 'http://image-iacv-dev.snow.com.vn/'; // https
// }

//dev

// class ConfigAPI {
//   static const String url_socketIO = 'http://iacv-io-dev.snow.com.vn/';
//   static const String urlImg = 'http://image-iacv-dev.snow.com.vn/'; // https
// }
