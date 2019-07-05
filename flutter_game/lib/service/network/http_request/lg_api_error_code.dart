abstract class LGErrorCode {
  static const int unDefine                                    = -1;
  static const int success                                     = 200;
  static const int paramVerify                                 = 1001; ///< 参数验证未通过
  static const int paramFormatVerify                           = 1002; ///< 参数组成验证未通过
  static const int paramLength                                 = 1003; ///< 参数长度验证未通过
  static const int accountNameExist                            = 1004; ///< 用户名已存在
  static const int mobileExist                                 = 1005; ///< 手机号已存在
  static const int verifyCode                                  = 1006; ///< 短信验证码校验未通过
  static const int register                                    = 1007; ///< 注册失败
  static const int verifyCodeExist                             = 1008; ///< 注册、忘记密码验证码已经存在了(注册、忘记密码验证码还有效)
  static const int verifyFetch                                 = 1009; ///< 注册、忘记密码验证码发送失败
  static const int userDenied                                  = 1010; ///< 用户封停
  static const int password                                    = 1011; ///< 密码校验未通过
  static const int notFountAccount                             = 1012; ///< 没找对应的用户数据
  static const int forgetPwd                                   = 1013; ///< 忘记密码执行失败
  static const int accessToken                                 = 1014; ///< access_token校验未通过
  static const int mobileFormat                                = 1015; ///< 手机号校验未通过。必须是合规的手机号
  
  static const int betParamError                               = 2001; ///< 参数验证未通过
  static const int notFoundOdds                                = 2002; ///< 未找到赔率数据
  static const int betForbid                                   = 2003; ///< 当前不允许下注
  static const int overflow                                    = 2004; ///< 下注金额超出范围
  static const int betFailed                                   = 2005; ///< 下注失败
  static const int betError                                    = 2006; ///< 下注异常
}