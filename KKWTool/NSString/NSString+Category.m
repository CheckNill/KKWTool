//
//  NSString+Category.m
//  YCYRBank
//
//  Created by 侯荡荡 on 16/4/27.
//  Copyright © 2016年 Hou. All rights reserved.
//

#import "NSString+Category.h"

/** 验证码长度 */
#define LENGTH_VERIFY_CODE          6
#define K_CURRENT_TIMESTAMP         [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

@implementation NSString (Category)

- (BOOL)isValidPWD{
    
    if (self.length < 8 || self.length > 18) {
        return NO;
    }
    BOOL hasChar = NO;
    BOOL hasNum = NO;
    BOOL haslitChar = NO;
    NSInteger alength = [self length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [self characterAtIndex:i];
        NSString *temp = [self substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            NSLog(@"字符串中含有中文");
        }else if((commitChar>64)&&(commitChar<91)){
            NSLog(@"字符串中含有大写英文字母");
            hasChar = YES;
        }else if((commitChar>96)&&(commitChar<123)){
            NSLog(@"字符串中含有小写英文字母");
            haslitChar = YES;
        }else if((commitChar>47)&&(commitChar<58)){
            hasNum = YES;
            NSLog(@"字符串中含有数字");
        }else{
            NSLog(@"字符串中含有非法字符");
        }
    }
    return hasNum && hasChar && haslitChar;
}


- (NSString *)hiddenMidIdentityCard{
    
    if (!(self.length == 15 || self.length == 18)) return self;
    
    NSMutableString *string = [self mutableCopy];
    if (self.length == 18) {
        [string replaceCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
        return string;
    }else{
        
        [string replaceCharactersInRange:NSMakeRange(6, 6) withString:@"******"];
        return string;
    }
}

- (NSString *)hiddenMidMobile{
    if (self.length != 11) {
        return self;
    }
    NSMutableString *string = [self mutableCopy];
    [string replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return string;
    
}

- (BOOL)isValidEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]+";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL) isValidMobileNumber {
    NSString *phoneRegex = @"^((\\+?)|(00?))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL) isValidVerifyCode {
    
    NSString* const VERIFYCODE = [NSString stringWithFormat:@"^d{%d}$", LENGTH_VERIFY_CODE];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VERIFYCODE];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidBankCardNumber {
    NSString* const BANKCARD = @"^(\\d{15}|\\d{16}|\\d{17}|\\d{18}|\\d{19}|\\d{20})$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidIdentityCard {
    NSString * identityCard = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([identityCard length] != 18 && [identityCard length]!= 15){
        return NO;
    }
    NSString *mmdd=@"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd=@"0229";
    NSString *year=@"(19|20)[0-9]{2}";
    NSString*leapYear=@"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString*yearMmdd=[NSString stringWithFormat:@"%@%@",year,mmdd];
    NSString*leapyearMmdd=[NSString stringWithFormat:@"%@%@",leapYear,leapMmdd];
    NSString*yyyyMmdd=[NSString stringWithFormat:@"((%@)|(%@)|(%@))",yearMmdd,leapyearMmdd,@"20000229"];
    NSString*area=@"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString*regex=[NSString stringWithFormat:@"%@%@%@",area,yyyyMmdd,@"[0-9]{3}[0-9Xx]"];
    
    NSPredicate*regexTest=[NSPredicate predicateWithFormat:@"SELF MATCHES%@",regex];
    if(![regexTest evaluateWithObject:identityCard]){
        return NO;
    }
    int summary=([identityCard substringWithRange:NSMakeRange(0,1)].intValue+[identityCard substringWithRange:NSMakeRange(10,1)].intValue)*7
    +([identityCard substringWithRange:NSMakeRange(1,1)].intValue+[identityCard substringWithRange:NSMakeRange(11,1)].intValue)*9
    +([identityCard substringWithRange:NSMakeRange(2,1)].intValue+[identityCard substringWithRange:NSMakeRange(12,1)].intValue)*10
    +([identityCard substringWithRange:NSMakeRange(3,1)].intValue+[identityCard substringWithRange:NSMakeRange(13,1)].intValue)*5
    +([identityCard substringWithRange:NSMakeRange(4,1)].intValue+[identityCard substringWithRange:NSMakeRange(14,1)].intValue)*8
    +([identityCard substringWithRange:NSMakeRange(5,1)].intValue+[identityCard substringWithRange:NSMakeRange(15,1)].intValue)*4
    +([identityCard substringWithRange:NSMakeRange(6,1)].intValue+[identityCard substringWithRange:NSMakeRange(16,1)].intValue)*2
    +[identityCard substringWithRange:NSMakeRange(7,1)].intValue*1+[identityCard substringWithRange:NSMakeRange(8,1)].intValue*6
    +[identityCard substringWithRange:NSMakeRange(9,1)].intValue*3;
    NSInteger remainder=summary%11;
    NSString*checkBit=@"";
    NSString*checkString=@"10X98765432";
    checkBit=[checkString substringWithRange:NSMakeRange(remainder,1)];//判断校验位
    return[checkBit isEqualToString:[[identityCard substringWithRange:NSMakeRange(17,1)]uppercaseString]];
    
}

- (BOOL) isValidZip {
    NSString* const IDENTITY = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

+ (NSString *)validPassword:(NSString *)pwd prefix:(NSString *)prefix{
    NSString *prompt = nil;
    NSString *prefixCopy = prefix ? [prefix copy] : @"";
    if (pwd.length == 0) {
        prompt = [NSString stringWithFormat:KKWTool_STR(@"%@ Password cannot be empty", nil),prefixCopy];
    }
    
    if (pwd.length > 20) {
        prompt = [NSString stringWithFormat:KKWTool_STR(@"%@ Password must be 8-20 numbers and letters", nil),prefixCopy];
    }
    
    if (pwd.length < 8) {
        prompt = [NSString stringWithFormat:KKWTool_STR(@"%@ Password must be 8-20 numbers and letters", nil),prefixCopy];
    }
    return prompt;
}

- (BOOL) hasExistedSpace {
    return ([self rangeOfString:@" "].length > 0);
}

+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil || string == NULL || [string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

+ (BOOL) isPureCharCharacters:(NSString *)string{
    // 编写正则表达式：只能是英文
    NSString *regex = @"^[a-zA-Z]*$";
    // 创建谓词对象并设定条件的表达式
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    // 对字符串进行判断
    if ([predicate evaluateWithObject:string]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) isPureInt:(NSString *)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

@end



@implementation NSString (urlEncode)

- (NSString *)URLEncodedString {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
}

@end
//NSMutableString *output = [NSMutableString string];
//const unsigned char *source = (const unsigned char *)[self UTF8String];
//int sourceLen = strlen((const char *)source);
//for (int i = 0; i < sourceLen; ++i) {
//    const unsigned char thisChar = source[i];
//    if (thisChar == ' '){
//        [output appendString:@"+"];
//    } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
//               (thisChar >= 'a' && thisChar <= 'z') ||
//               (thisChar >= 'A' && thisChar <= 'Z') ||
//               (thisChar >= '0' && thisChar <= '9')) {
//        [output appendFormat:@"%c", thisChar];
//    } else {
//        [output appendFormat:@"%%%02X", thisChar];
//    }
//}
//return output;



@implementation NSString (Format)

+ (NSString*) stringMobileFormat:(NSString *)mobile {
    
    if ([mobile isValidMobileNumber]) {
        NSMutableString* value = [[NSMutableString alloc] initWithString:mobile];
        [value insertString:@" " atIndex:3];
        [value insertString:@" " atIndex:8];
        return value;
    }
    
    return nil;
}


+ (NSString*) stringChineseFormat:(CGFloat)value{
    
    if (value / 100000000.0f >= 1) {
        return [NSString stringWithFormat:@"%.2f亿", value / 100000000.0f];
    }
    else if (value / 10000.0f >= 1 && value / 100000000.0f < 1) {
        return [NSString stringWithFormat:@"%.2f万", value / 10000.0f];
    }
    else {
        return [NSString stringWithFormat:@"%.2f", value];
    }
}

+ (NSString *)stringFormatterWithCurrency:(CGFloat)currency {
    
    NSString* value         = [NSString stringWithFormat:@"%.02f", currency];

    NSMutableString* string = [[NSMutableString alloc] init];
    [string appendString:[value substringFromIndex:[value length] - 3]];
    
    NSInteger index = [value length] - 6;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        index -= 3;
    }
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    return string;
}

+ (NSString *)stringByAppendingZeroWithString:(NSString *)string {
    
    NSString *str = [self isBlankString:string] ? @"0.00" : @".00";
    return [string stringByAppendingString:str];
}

+ (NSString *)stringByAppendingCommaWithString:(NSString *)string{
    //删除字符串中的空格 逗号
    NSArray *strArrayA = [string componentsSeparatedByString:@"."];
    NSString *str = strArrayA[0];
    
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"," withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"，" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSInteger length = [str length];
    NSMutableArray *strArray = [NSMutableArray array];
    for(int i = 0;i<length;i++)
    {
        NSRange range = {i, 1};
        NSString *strA = [str substringWithRange:range];
        [strArray addObject:strA];
    }
    NSInteger num = length/3;//对三求商2
    NSInteger temp = length%3;//对三求余1
    switch (temp) {
        case 0:
            for (NSInteger i = 1; i < num; i++) {
                
                [strArray insertObject:@"," atIndex:(4*(i-1)+3)];
                
            }
            break;
        case 1:
            for (NSInteger i = 0; i < num; i++) {
                
                [strArray insertObject:@"," atIndex:(4*i+temp)];
                
            }
            break;
        case 2:
            for (NSInteger i = 0; i < num; i++) {
                
                [strArray insertObject:@"," atIndex:(4*i+temp)];
                
            }
            break;
        default:
            break;
    }
    NSString *textMoney = @"";
    if(strArray.count>0)
    {
        for (int i = 0; i<strArray.count; i++) {
            NSString *text = [NSString stringWithFormat:@"%@",strArray[i]];
            textMoney = [textMoney stringByAppendingString:text];
        }
    }
    for (int i = 1; i < strArrayA.count; i++) {
        NSString *text = [NSString stringWithFormat:@".%@",strArrayA[i]];
        textMoney = [textMoney stringByAppendingString:text];
    }
    return textMoney;
    
}

@end




@implementation NSString (Math)

+ (NSString *)addWithBigNums:(NSString *)num1 num2:(NSString *)num2 {
    
    NSString *result = [NSString string];
    //确保num1大些，如果不是，则调换。
    if (num1.length < num2.length){
        result = [NSString stringWithString:num1];
        num1   = [NSString stringWithString:num2];
        num2   = [NSString stringWithString:result];
        result = [NSString string];
    }
    //进位
    NSInteger carryBit   = 0;
    //加法的最大位
    NSInteger largestBit = 0;
    
    for (NSInteger i = 1 ; i <= num2.length ; i++){
        //num1 的当前位
        NSInteger intNum1 = [[num1 substringWithRange:NSMakeRange(num1.length - i, 1)] integerValue];
        //num2 的当前位
        NSInteger intNum2 = [[num2 substringWithRange:NSMakeRange(num2.length - i, 1)] integerValue];
        
        NSInteger intTemp = intNum1 + intNum2 + carryBit;
        
        if (intTemp > 9){
            carryBit = 1;
            result = [NSString stringWithFormat:@"%zi%@",intTemp % 10,result];
        }else{
            carryBit = 0;
            result = [NSString stringWithFormat:@"%zi%@",intTemp,result];
        }
        if (i == num2.length){
            if (num1.length == num2.length){
                if (carryBit) result = [NSString stringWithFormat:@"%zi%@",carryBit,result];
            }else{
                largestBit = [[num1 substringWithRange:NSMakeRange(num1.length - i - 1, 1)] integerValue];
                NSString *restStringOfNum1 = [num1 substringWithRange:NSMakeRange(0, num1.length - num2.length - 1)];
                result = [NSString stringWithFormat:@"%@%zi%@", restStringOfNum1,largestBit + carryBit,result];
            }
        }
    }
    return result;
}

+ (NSString *)mutiplyWithBigNums:(NSString *)num1 num2:(NSString *)num2 {
    
    NSString *result = [NSString string];
    //按两位来分组每一个乘数
    NSArray *arrayNum1 = [self tearStringToArray:num1];
    NSArray *arrayNum2 = [self tearStringToArray:num2];
    //循环分组内的元素，相乘
    NSString *tempResult = [NSString string];
    
    for (NSInteger i = 0 ; i < [arrayNum1 count] ; i ++){
        NSInteger item1 = [[arrayNum1 objectAtIndex:i] intValue];
        for (NSInteger j = 0 ; j < [arrayNum2 count]; j ++){
            NSInteger item2 = [[arrayNum2 objectAtIndex:j] intValue];
            NSInteger temp  = item1 * item2;
            tempResult = [NSString stringWithFormat:@"%zi",temp];
            for (NSInteger k = 0 ; k < i + j ; k ++){
                tempResult = [tempResult stringByAppendingString:@"0"];
            }
            if (result.length){
                result = [self addWithBigNums:result num2:tempResult];
            }else{
                result = tempResult;
            }
        }
    }
    return result;
}

+ (NSArray *)tearStringToArray:(NSString *)string {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:string.length];
    for (unsigned long i = string.length; i > 0; i --){
        NSString *temp = [string substringWithRange:NSMakeRange(i - 1, 1)];
        [array addObject:temp];
    }
    return [array mutableCopy];
}


+ (NSString *)roundDown:(double)value afterPoint:(NSInteger)position {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:value];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSString *)roundUp:(double)value afterPoint:(NSInteger)position {
    
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp
                                                                                                      scale:position
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:value];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

@end




@implementation NSString (Additions)

+ (NSRegularExpression *)emojsRgx{

    static NSRegularExpression *regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!regex){
            NSError *error = nil;
            NSString *pattern = @"[^\\u0000-\\uFFFF]";//FF 1个字节=8位=2的8次方，16的2次方
            regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
        }
    });
    
    return regex;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    NSArray *result = [[NSString emojsRgx] matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    
    return result && result.count > 0;
}

- (NSString*)removeEmoji
{
    NSRegularExpression *regex = [NSString emojsRgx];
    
    NSString *processedString = regex ? [regex stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""] : self;

    return processedString;
}

- (NSString *)stringValue {
    return self;
}

- (CGSize)sizeWithConstrainedSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    
    CGSize expectedSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode            = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing              = lineSpacing;
        NSDictionary *attributes                = @{NSFontAttributeName:font,
                                                    NSParagraphStyleAttributeName:paragraphStyle.copy};
        expectedSize                            = [self boundingRectWithSize:size
                                                                     options:NSStringDrawingUsesLineFragmentOrigin |
                                                                             NSStringDrawingUsesFontLeading
                                                                  attributes:attributes
                                                                     context:nil].size;
    } else {
        expectedSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    
    return CGSizeMake(ceil(expectedSize.width), ceil(expectedSize.height));
}

- (CGSize)sizeWithMaxWidth:(CGFloat)width font:(UIFont *)font {
    return [self sizeWithConstrainedSize:CGSizeMake(width, FLT_MAX) font:font lineSpacing:0];
}

- (CGSize)sizeWithMaxWidth:(CGFloat)width font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    return [self sizeWithConstrainedSize:CGSizeMake(width, FLT_MAX) font:font lineSpacing:lineSpacing];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *dict = @{ NSFontAttributeName : font };
    CGSize textSize = [self boundingRectWithSize:maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:dict
                                         context:nil].size;
    return textSize;
}

+ (NSString *)generateRandomString {
    
    NSString *string = [[NSString alloc]init];
    for (NSInteger i = 0; i < 32; i++) {
        NSInteger number = arc4random() % 36;
        if (number < 10) {
            NSInteger figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%zi", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            NSInteger figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    
    
    return [string stringByAppendingString:K_CURRENT_TIMESTAMP];
}

+ (NSInteger)charsCountDespiteChineseCountInString:(NSString *)str
{
    NSInteger letterCount = 0;
    for(int i = 0; i<str.length; i++)
    {
        NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
        if(strlen([subStr cStringUsingEncoding:NSUTF8StringEncoding]) == 1)
        {
            letterCount ++;
        }
    }
    return letterCount;
}

@end






