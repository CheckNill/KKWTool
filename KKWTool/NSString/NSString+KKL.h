//
//  NSString+KKL.h
//  KuarkPay
//
//  Created by john on 2018/3/16.
//  Copyright © 2018年 toxicanty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KKL)

/**
 根据id 匹配钱包icon

 @param coinId <#coinId description#>
 @return <#return value description#>
 */
+ (NSString *)coinIconWithCoinId:(NSString *)coinId;

/**
 是否是合法的钱包地址

 @param coinAddress <#coinAddress description#>
 @return <#return value description#>
 */
+ (BOOL)isValidCoinAddress:(NSString *)coinAddress;

/**
 验证密码有效性

 @param password 密码
 @return <#return value description#>
 */
+ (BOOL)isValidPassword:(NSString *)password;

@end
