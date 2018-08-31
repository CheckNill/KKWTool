//
//  UIColor+StyleSheet.m
//  KuarkPay
//
//  Created by john on 2018/5/17.
//  Copyright © 2018年 toxicanty. All rights reserved.
//

#import "UIColor+StyleSheet.h"
#import "UIColor+CZAddition.h"
#import "UIColor+HexExtension.h"
@implementation UIColor (StyleSheet)

+ (UIColor *)baseBackckgroundColor{
    //return [UIColor colorWithHexString:@"#f5f5f5"];
    return [UIColor yw_colorWithRed:244.0 green:244.0 blue:244.0];
}

+ (UIColor *)navBlueColor{
    return [UIColor colorWithHexString:@"#406ff4"];
}

+ (UIColor *)segmentTintColor{
    return [UIColor colorWithHexString:@"#406ff4"];
}

+ (UIColor *)kkMainTextColor{
    return [UIColor colorWithHexString:@"#333333"];
}

+ (UIColor *)kkDarkGrayColor{
    return [UIColor colorWithHexString:@"#666666"];
}

+ (UIColor *)kkLightGrayColor{
    return [UIColor colorWithHexString:@"#999999"];
}

+ (UIColor *)kkGreenColor{
    return [UIColor colorWithHexString:@"#39cc88"];
}

+ (UIColor *)kkRedColor{
    return [UIColor colorWithHexString:@"#ff7a70"];
}

+ (UIColor *)kkBlueColor{
    return [UIColor colorWithHexString:@"#4275FF"];
}

+ (UIColor *)separateLineColor{
    return  [UIColor colorWithHexString:@"#E6E6E6"];
}

+ (UIColor *)separateTableLineColor{
    return  [UIColor colorWithHexString:@"#E6E6EB"];
}

+ (UIColor *)boxLineColor{
    return  [UIColor colorWithHexString:@"#CCCCCC"];
}


@end
