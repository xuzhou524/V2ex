//
//  LDColor.h
//  LongDai
//
//  Created by gozap on 2017/11/17.
//  Copyright © 2017年 Gozap. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  龙贷3.0的配色
 */
@interface LDColor : UIColor
+ (UIColor *)colorWithR255:(NSInteger)red G255:(NSInteger)green B255:(NSInteger)blue A255:(NSInteger)alpha;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createImageWithColor:(UIColor *)color withSize:(CGSize)size;


+ (UIColor *)backgroudColor;
+ (UIColor *)separatorColor;

/* Red */
+ (UIColor *)ldRed_218_0_0;
+ (UIColor *)ldRed_222_36_61;
+ (UIColor *)ldRed_236_71_82;
+ (UIColor *)ldRed_255_87_60;
+ (UIColor *)ldRed_243_90_93;
+ (UIColor *)ldRed_243_100_118;
+ (UIColor *)ldRed_251_209_217;

/*  gray  */
+ (UIColor *)ldgray42;
+ (UIColor *)ldgray69;
+ (UIColor *)ldgray98;
+ (UIColor *)ldgray148;
+ (UIColor *)ldgray190;
+ (UIColor *)ldgray210;
+ (UIColor *)ldgray_40_47_66;
+ (UIColor *)ldgray_93_104_125;
+ (UIColor *)ldgray_108_108_113;
+ (UIColor *)ldgray_116_124_140;
+ (UIColor *)ldgray_139_148_169;
+ (UIColor *)ldgray_177_186_202;
+ (UIColor *)ldgray_207_211_219;


/* Blue */
+ (UIColor *)ldBlue_44_84_150;
+ (UIColor *)ldBlue_62_72_96;
+ (UIColor *)ldblue_140_164_217;

/* Yellow */
+ (UIColor *)ldYellow_255_180_45;
+ (UIColor *)ldYellow_247_187_192;
+ (UIColor *)ldYellow_255_119_54;

/* Green */
+ (UIColor *)ldGreen_141_168_73;
+ (UIColor *)ldGreen_47_177_111;
+ (UIColor *)ldGreen_232_242_237;
@end
