//
//  CJCSwitch.h
//  CJCSwitch
//
//  Created by Ashuro on 16/3/16.
//  Copyright © 2016年 Ashuro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJCSwitch : UIControl

@property (nonatomic , assign) BOOL on;

@property (nonatomic , strong) NSString * onText;

@property (nonatomic , strong) NSString * offText;

@property (nonatomic , strong) UIColor *onTextColor;

@property (nonatomic , strong) UIColor *offTextColor;

@property (nonatomic , strong) UIColor *onColor;

@property (nonatomic , strong) UIColor *offColor;

@property (nonatomic , strong) UIColor *borderColor;


- (void) setSwitchOn : (BOOL) value;

- (void) setSwitchOn : (BOOL) value withAnimotion : (BOOL) isAnimotion;

@end
