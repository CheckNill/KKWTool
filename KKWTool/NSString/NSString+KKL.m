//
//  NSString+KKL.m
//  KuarkPay
//
//  Created by john on 2018/3/16.
//  Copyright © 2018年 toxicanty. All rights reserved.
//

#import "NSString+KKL.h"

static NSRegularExpression *CoinAddressRegex = nil;

@implementation NSString (KKL)

+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error = nil;
        CoinAddressRegex = [[NSRegularExpression alloc] initWithPattern:@"^-?0x[0-9A-Fa-f]*$" options:NSRegularExpressionCaseInsensitive error:&error];
    });
}

+ (NSString *)coinIconWithCoinId:(NSString *)coinId{
    NSString *defaultIcon = @"wallet_list_coin_b";
    NSString *icon = defaultIcon;
    if([coinId isEqualToString:@"328498433901461505"]){
        //Ethereum
        icon = @"ETH-detail";
    }else if ([coinId isEqualToString:@"328499027036471297"]){
        //Bitcoin
        icon = @"";
    }else if ([coinId isEqualToString:@""]){
        icon = @"";
    }
    return icon;
}

+ (BOOL)isValidCoinAddress:(NSString *)coinAddress{
    if(coinAddress.length == 0){
        return NO;
    }
    NSArray *results = [CoinAddressRegex matchesInString:coinAddress options:NSMatchingReportProgress range:NSMakeRange(0, coinAddress.length)];
    
    return results.count > 0;
}

+ (BOOL)isValidPassword:(NSString *)password{
    
    NSString *regex = @"^[a-zA-Z0-9]{8,20}$";
    NSPredicate *pwdText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL valid = [pwdText evaluateWithObject:password];
    
    return valid;
}

@end
