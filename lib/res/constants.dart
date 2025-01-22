abstract class Constants {
  static const southAfricaAreaCode = '+27';

  static const startPageIndex = 1;
  static const pageSize = 20;

  static const postcodeSender = '1619';

  // 默认时区
  static const defaultTimezone = '-2';

  // 地址簿
  static const maxNameLength = 50;
  static const mobilePhoneLength = 9;
  static const postcodeLength = 4;
  static const maxAddressLength = 50;
  static const maxCompanyLength = 50;

  // 派送类型（0：派送；1：自提；）
  static const defaultDeliveryType = 0;
  // 订单类型,默认0:本地派送
  static const defaultOrderType = 0;

  static const insurancePremiumDescription = """
The insurance compensation amount is based on the actual value of goods. Therefore, we will confirm the compensation amount after the CSD Staff can confirm the values of the goods which is claimed from client side as following:

a. If the value of the goods is larger than the insured amount, the compensation will be limited to the maximum of insured amount  that customer paid correspondingly.

b. If the value of the goods is less than the insured amount, the compensation will be limited to the minimum of insured amount that customer paid correspondingly.

c. If the value of the goods cannot be confirmed, the compensation will be limited to the minimum of insured amount that customer paid correspondingly.""";
  static const exceed30kgAlertDesc =
      'Order weight ＞ 30kg, please contact Buffalo Sales Support team to obtain a quotation.';
}
