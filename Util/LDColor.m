//
//  LDColor.m
//  LongDai
//
//  Created by gozap on 2017/11/17.
//  Copyright © 2017年 Gozap. All rights reserved.
//

#import "LDColor.h"

@implementation LDColor

+ (UIColor *)colorWithR255:(NSInteger)red G255:(NSInteger)green B255:(NSInteger)blue A255:(NSInteger)alpha{
    return ([UIColor colorWithRed:((CGFloat) red / 255) green:((CGFloat) green / 255) blue:((CGFloat) blue / 255) alpha:((CGFloat) alpha / 255)]);
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIColor *)backgroudColor {
    return [LDColor colorWithR255:244 G255:244 B255:247 A255:255];
}
+ (UIColor *)separatorColor {
    return [LDColor colorWithR255:244 G255:244 B255:247 A255:255];
}

+ (UIColor *)ldRed_222_36_61{
    return [LDColor colorWithR255:225 G255:41 B255:70 A255:255];
}
+ (UIColor *)ldRed_236_71_82{
    return [LDColor colorWithR255:236 G255:71 B255:82 A255:255];
}
+ (UIColor *)ldRed_255_87_60{
    return [LDColor colorWithR255:255 G255:87 B255:60 A255:255];
}
+ (UIColor *)ldRed_243_90_93{
    return [LDColor colorWithR255:243 G255:90 B255:93 A255:255];
}
+ (UIColor *)ldRed_243_100_118{
    return [LDColor colorWithR255:243 G255:100 B255:118 A255:255];
}
+ (UIColor *)ldRed_251_209_217{
    return [LDColor colorWithR255:251 G255:209 B255:217 A255:255];
}
+ (UIColor *)ldRed_218_0_0{
    return [LDColor colorWithR255:218 G255:0 B255:0 A255:255];
}

+ (UIColor *)ldgray42{
    return [LDColor colorWithR255:42 G255:42 B255:42 A255:255];
}
+ (UIColor *)ldgray69{
    return [LDColor colorWithR255:69 G255:69 B255:69 A255:255];
}
+ (UIColor *)ldgray98{
    return [LDColor colorWithR255:98 G255:98 B255:98 A255:255];
}
+ (UIColor *)ldgray148{
    return [LDColor colorWithR255:148 G255:148 B255:148 A255:255];
}
+ (UIColor *)ldgray190{
    return [LDColor colorWithR255:190 G255:190 B255:190 A255:255];
}
+ (UIColor *)ldgray210{
    return [LDColor colorWithR255:210 G255:210 B255:210 A255:255];
}
+ (UIColor *)ldgray_40_47_66{
    return [LDColor colorWithR255:40 G255:47 B255:66 A255:255];
}
+ (UIColor *)ldgray_93_104_125{
    return [LDColor colorWithR255:93 G255:104 B255:125 A255:255];
}
+ (UIColor *)ldgray_108_108_113{
    return [LDColor colorWithR255:108 G255:108 B255:113 A255:255];
}
+ (UIColor *)ldgray_116_124_140{
    return [LDColor colorWithR255:120 G255:130 B255:155 A255:255];
}
+ (UIColor *)ldgray_139_148_169{
    return [LDColor colorWithR255:139 G255:148 B255:169 A255:255];
}
+ (UIColor *)ldgray_177_186_202{
    return [LDColor colorWithR255:177 G255:186 B255:202 A255:255];
}
+ (UIColor *)ldgray_207_211_219{
    return [LDColor colorWithR255:207 G255:211 B255:219 A255:255];
}


+ (UIColor *)ldBlue_44_84_150{
    return [LDColor colorWithR255:44 G255:84 B255:150 A255:255];
}
+ (UIColor *)ldBlue_62_72_96{
    return [LDColor colorWithR255:62 G255:72 B255:96 A255:255];
}
+ (UIColor *)ldblue_140_164_217{
    return [LDColor colorWithR255:140 G255:164 B255:217 A255:255];
}


+ (UIColor *)ldYellow_255_180_45{
    return [LDColor colorWithR255:255 G255:180 B255:45 A255:255];
}
+ (UIColor *)ldYellow_247_187_192{
    return [LDColor colorWithR255:247 G255:187 B255:192 A255:255];
}
+ (UIColor *)ldYellow_255_119_54{
    return [LDColor colorWithR255:255 G255:119 B255:54 A255:255];
}


+ (UIColor *)ldGreen_141_168_73 {
    return [LDColor colorWithR255:141 G255:168 B255:73 A255:255];
}
+ (UIColor *)ldGreen_47_177_111 {
    return [LDColor colorWithR255:47 G255:177 B255:111 A255:255];
}
+ (UIColor *)ldGreen_232_242_237 {
    return [LDColor colorWithR255:232 G255:242 B255:237 A255:255];
}
@end
