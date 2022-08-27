//
//  RJBasicHead.h
//  RingDemo
//
//  Created by 任睿杰 on 2022/8/27.
//

#import <UIKit/UIKit.h>

#ifndef RJBasicHead_h
#define RJBasicHead_h

#define SCREEN_HEIGHT                       [[UIScreen mainScreen] bounds].size.height
#define kTabBarHeight                   ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define UIColorFromHex(hexValue)            UIColorFromHexWithAlpha(hexValue, 1.0)
#define UIColorFromHexWithAlpha(hexValue,a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]

#endif /* RJBasicHead_h */
