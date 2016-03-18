//
//  CJCSwitch.m
//  CJCSwitch
//
//  Created by Ashuro on 16/3/16.
//  Copyright © 2016年 Ashuro. All rights reserved.
//

#import "CJCSwitch.h"

#define defaultOpenColor [UIColor cyanColor]
#define defaultOffColor [UIColor whiteColor]
#define defaultBorderColor [UIColor colorWithRed:0.890196 green:0.890196 blue:0.890196 alpha:1.000000]


@interface CJCSwitch ()<UIGestureRecognizerDelegate> {
    
   BOOL _isAnimotion;
}

@property (nonatomic , strong) UIView * backgroundView;
@property (nonatomic , strong) UIView * contentView;
@property (nonatomic , strong) UIView * circleView;

@property (nonatomic , strong) UILabel *onLabel;
@property (nonatomic , strong) UILabel *offLabel;
@end

@implementation CJCSwitch

- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubviews];
  
    }

    return self;
}


- (id)initWithCoder:(NSCoder*)coder
{
    self = [super initWithCoder:coder];
    if (self) {

        
        [self addSubviews];
    
    }
    return self;
}

- (void) addSubviews {

    
    if (self.borderColor) {
        
        self.backgroundColor = self.borderColor;
        
    } else {
        
        self.backgroundColor = defaultBorderColor;
        
    }
    
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.backgroundView];
    

    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[backgroundView]-2-|" options:0 metrics:nil views:@{@"backgroundView":self.backgroundView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[backgroundView]-2-|" options:0 metrics:nil views:@{@"backgroundView":self.backgroundView}]];
    
    if(self.on) {
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake( self.frame.size.width - (self.frame.size.height - 4)/2, (self.frame.size.height - 4)/2, 0, 0)];
        
    } else {
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 4 , self.frame.size.height - 4)];
        
    }
    
    if (self.offColor) {
        
        self.contentView.backgroundColor = self.offColor;
        
    } else {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
    }

    
    [self.backgroundView addSubview:self.contentView];

    
    
    if (self.on) {
        
        self.circleView = [[UIView alloc] initWithFrame:CGRectMake(self.backgroundView.frame.size.width/2, self.backgroundView.frame.size.height/2, 0, 0)];
        
    } else {
        
        self.circleView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.height -2, self.frame.size.height-2)];

    }
    
    if (self.on) {
        
        self.circleView.layer.borderColor = [UIColor whiteColor].CGColor;

    } else {
        
        if (self.borderColor) {
            
            self.circleView.layer.borderColor = self.borderColor.CGColor;
            
        } else {
            
            self.circleView.layer.borderColor = defaultBorderColor.CGColor;

        }
        
    }
    
    
    self.circleView.layer.borderWidth = 1.0;
    
    self.circleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.circleView.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.circleView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    self.circleView.layer.shadowRadius = 5;
    
    
    self.circleView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.circleView];
    
    
    //设置圆角
    self.layer.cornerRadius = self.frame.size.height/2;
    self.circleView.layer.cornerRadius = self.circleView.frame.size.height/2;
    self.backgroundView.layer.cornerRadius = (self.frame.size.height - 4)/2;
    self.contentView.layer.cornerRadius = (self.frame.size.height - 4)/2;
    
    
    //设置开关文字
    
    self.offLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height + 5, 0, self.frame.size.width - self.frame.size.height*1.5, self.frame.size.height)];
    
    if (self.offTextColor) {
        
        self.offLabel.textColor = self.offTextColor;
        
    } else {
        
        self.offLabel.textColor = defaultBorderColor;
        
    }
    

    self.offLabel.textAlignment = NSTextAlignmentCenter;

    
    [self addSubview:self.offLabel];
    
    self.onLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height/2 - 5, 0, self.frame.size.width - self.frame.size.height*1.5, self.frame.size.height)];
    
    if (self.onTextColor) {
        
        self.onLabel.textColor = self.onTextColor;
        
    } else {
        
        self.onLabel.textColor = [UIColor whiteColor];
    }
    
    self.onLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.onLabel];
    
    self.offLabel.hidden = self.on;
    self.onLabel.hidden = !self.on;
    
    self.offLabel.numberOfLines = 0;
    self.onLabel.numberOfLines = 0;
    
    self.offLabel.font = [UIFont systemFontOfSize:12];
    self.onLabel.font = [UIFont systemFontOfSize:12];
    
    self.offLabel.adjustsFontSizeToFitWidth = YES;
    self.onLabel.adjustsFontSizeToFitWidth = YES;
    
    //设置手势
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action:@selector(panAction:)];
    
    [self addGestureRecognizer:pan];
    
}

#pragma mark - 操作手势

- (void) panAction: (UIPanGestureRecognizer *) sender {
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGPoint point = [sender translationInView:self];
        
        if (point.x < 0) {
            
            if (self.circleView.frame.origin.x != 1) {
                
                self.offLabel.hidden = NO;
                self.onLabel.hidden = YES;
                
                if (self.borderColor) {
                    
                    self.circleView.layer.borderColor = self.borderColor.CGColor;
                    
                } else {
                    
                    self.circleView.layer.borderColor = defaultBorderColor.CGColor;
                    
                }
                
                
                if (self.borderColor) {
                    
                    self.backgroundColor = self.borderColor;
                    
                    
                } else {
                    
                    self.backgroundColor = defaultBorderColor;
                    
                }
                
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    self.circleView.frame = CGRectMake(1, 1, self.circleView.frame.size.width, self.circleView.frame.size.height);
                    
                    
                } completion:^(BOOL finished) {
                    
                    self.on = NO;
                    
                    [self sendActionsForControlEvents:UIControlEventValueChanged];
                    
                }];
                
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    
                    self.contentView.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
                    
                    NSLog(@"%f",self.contentView.frame.size.height);
                    

                    
                    
                } completion:^(BOOL finished) {
                    
                    
                    
                    if (self.borderColor) {
                        
                        self.backgroundView.backgroundColor = self.borderColor;
                        
                        self.circleView.layer.borderColor = self.borderColor.CGColor;
                        
                    } else {
                        
                        self.backgroundView.backgroundColor = defaultBorderColor;
                        
                        self.circleView.layer.borderColor = defaultBorderColor.CGColor;
                        
                    }
                    
                    
                }];

                
            }
            
        } else {
            
            if (self.circleView.frame.origin.x == 1) {
                
                self.offLabel.hidden = YES;
                self.onLabel.hidden = NO;
                
                
                self.circleView.layer.borderColor = [UIColor whiteColor].CGColor;
                
                if (self.onColor) {
                    
                    self.backgroundColor = self.onColor;
                    self.backgroundView.backgroundColor = self.onColor;
                    
                    
                } else {
                    
                    self.backgroundColor = defaultOpenColor;
                    self.backgroundView.backgroundColor = defaultOpenColor;
                    
                }
                
                
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    self.circleView.frame = CGRectMake(self.frame.size.width - self.frame.size.height + 1, 1, self.circleView.frame.size.width, self.circleView.frame.size.height);
                    
                    
                } completion:^(BOOL finished) {
                    
                    self.on = YES;
                    
                    [self sendActionsForControlEvents:UIControlEventValueChanged];
                    
                }];
                
                [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    
                    self.contentView.frame = CGRectMake(self.frame.size.width - (self.frame.size.height - 4)/2, (self.frame.size.height - 4)/2, 0, 0);
                    
                    
                } completion:^(BOOL finished) {
                    
                    
                }];

            }
            
        }
        
    }

}

- (void) tapAction: (UITapGestureRecognizer *) sender {
    
    self.offLabel.hidden = YES;
    self.onLabel.hidden = YES;
    
    if(self.circleView.frame.origin.x == 1) {
        
        self.offLabel.hidden = YES;
        self.onLabel.hidden = NO;
        
        
        self.circleView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        if (self.onColor) {
            
            self.backgroundColor = self.onColor;
            self.backgroundView.backgroundColor = self.onColor;
            
            
        } else {
            
            self.backgroundColor = defaultOpenColor;
            self.backgroundView.backgroundColor = defaultOpenColor;
            
        }

        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.circleView.frame = CGRectMake(self.frame.size.width - self.frame.size.height + 1, 1, self.circleView.frame.size.width, self.circleView.frame.size.height);

            
        } completion:^(BOOL finished) {
            
            self.on = YES;
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];

        }];
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.contentView.frame = CGRectMake(self.frame.size.width - (self.frame.size.height - 4)/2, (self.frame.size.height - 4)/2, 0, 0);
            

            
        } completion:^(BOOL finished) {
            
            
        }];

        

        
        
    } else {
        
        
        self.offLabel.hidden = NO;
        self.onLabel.hidden = YES;
        
        if (self.borderColor) {
            
            self.circleView.layer.borderColor = self.borderColor.CGColor;
            
        } else {
            
            self.circleView.layer.borderColor = defaultBorderColor.CGColor;
            
        }

        
        if (self.borderColor) {
            
            self.backgroundColor = self.borderColor;
            
            
        } else {
            
            self.backgroundColor = defaultBorderColor;
            
        }

        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.circleView.frame = CGRectMake(1, 1, self.circleView.frame.size.width, self.circleView.frame.size.height);

            
        } completion:^(BOOL finished) {

            self.on = NO;
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
            
        }];
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            
            self.contentView.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.backgroundView.frame.size.height);
            

            
            
        } completion:^(BOOL finished) {
            

            
            if (self.borderColor) {
                
                self.backgroundView.backgroundColor = self.borderColor;
                
                self.circleView.layer.borderColor = self.borderColor.CGColor;
                
            } else {
                
                self.backgroundView.backgroundColor = defaultBorderColor;
                
                self.circleView.layer.borderColor = defaultBorderColor.CGColor;
                
            }

  
        }];
        
        
    }
    
}

#pragma mark - 代码控制开关
- (void) setSwitchOn:(BOOL)value {
    
    self.on = value;
    
}

- (void) setSwitchOn:(BOOL)value withAnimotion:(BOOL)isAnimotion {
    
    _isAnimotion = isAnimotion;
    self.on = value;
}

#pragma mark - set方法
- (void) setOffText:(NSString *)offText {
    
    _offLabel.text = offText;
    
    [self setNeedsLayout];

}

- (void) setOnText:(NSString *)onText {
    
    _onLabel.text = onText;
    
    [self setNeedsLayout];

}

- (void) setOffColor:(UIColor *)offColor {
    
    _offColor = offColor;
    
    self.contentView.backgroundColor = _offColor;
    
    [self setNeedsLayout];
}

- (void) setOnColor:(UIColor *)onColor {
    
    _onColor = onColor;
    
    if (_on) {
        
        self.backgroundColor = onColor;
        _backgroundView.backgroundColor = onColor;
        
    }
    
    [self setNeedsLayout];
}

- (void) setOnTextColor:(UIColor *)onTextColor {
    
    _onTextColor = onTextColor;
    
    _onLabel.textColor = onTextColor;
    
    [self setNeedsLayout];
}

- (void) setOffTextColor:(UIColor *)offTextColor {
    
    _offTextColor = offTextColor;
    
    _offLabel.textColor = offTextColor;
    
    [self setNeedsLayout];
    
}

- (void) setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    
    if (_on) {
        
        self.backgroundColor = _onColor;
        _circleView.layer.borderColor = [UIColor whiteColor].CGColor;
        
    } else {
        
        self.backgroundColor = borderColor;
        _circleView.layer.borderColor = borderColor.CGColor;
        
    }
    
    [self setNeedsLayout];
}

- (void) setOn:(BOOL)on {
    
    _on = on;
    
    if (_isAnimotion) {
        
        
        if (on) {
            
            _offLabel.hidden = YES;
            _onLabel.hidden = NO;
            
            
            _contentView.frame = CGRectMake(_backgroundView.frame.size.width/2, _backgroundView.frame.size.height/2, 0, 0);
            
            if (_onColor) {
                
                self.backgroundColor = _onColor;
                _backgroundView.backgroundColor = _onColor;
                
                
            } else {
                
                self.backgroundColor = defaultOpenColor;
                _backgroundView.backgroundColor = defaultOpenColor;
                
            }
            
            _circleView.layer.borderColor = [UIColor whiteColor].CGColor;

            
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _circleView.frame = CGRectMake(self.frame.size.width - self.frame.size.height + 1, 1, _circleView.frame.size.width, _circleView.frame.size.height);
                
                
            } completion:^(BOOL finished) {
                
                _on = YES;
                
                _isAnimotion = NO;
                
                
            }];
            
            
            
            
        } else {
            
            _offLabel.hidden = NO;
            _onLabel.hidden = YES;
            
            if (_borderColor) {
                
                self.backgroundColor = _borderColor;
                
                
            } else {
                
                self.backgroundColor = defaultBorderColor;
                
            }
            
            if (_borderColor) {
                
                _backgroundView.backgroundColor = _borderColor;
                
                _circleView.layer.borderColor = _borderColor.CGColor;
                
            } else {
                
                _backgroundView.backgroundColor = defaultBorderColor;
                
                _circleView.layer.borderColor = defaultBorderColor.CGColor;
                
            }
            
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _circleView.frame = CGRectMake(1, 1, _circleView.frame.size.width, _circleView.frame.size.height);
                
                
            } completion:^(BOOL finished) {
                
                _on = NO;
                _isAnimotion = NO;
 
            }];
            
            [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
                
                _contentView.frame = CGRectMake(0, 0, _backgroundView.frame.size.width, _backgroundView.frame.size.height);
                
                
            } completion:^(BOOL finished) {
  
                
                
            }];

        }
        
        [self setNeedsLayout];

        
        
    } else {
        
        
        if (on) {
            
            _offLabel.hidden = YES;
            _onLabel.hidden = NO;
            
            
            _contentView.frame = CGRectMake(_backgroundView.frame.size.width/2, _backgroundView.frame.size.height/2, 0, 0);
            
            if (_onColor) {
                
                self.backgroundColor = _onColor;
                _backgroundView.backgroundColor = _onColor;
                
                
            } else {
                
                self.backgroundColor = defaultOpenColor;
                _backgroundView.backgroundColor = defaultOpenColor;
                
            }
            
            _circleView.layer.borderColor = [UIColor whiteColor].CGColor;
            
            _circleView.frame = CGRectMake(self.frame.size.width - self.frame.size.height + 1, 1, _circleView.frame.size.width, _circleView.frame.size.height);
            
            _on = YES;
            
        } else {
            
            _offLabel.hidden = NO;
            _onLabel.hidden = YES;
            
            if (_borderColor) {
                
                self.backgroundColor = _borderColor;
                
                
            } else {
                
                self.backgroundColor = defaultBorderColor;
                
            }
            
            if (_borderColor) {
                
                _backgroundView.backgroundColor = _borderColor;
                
                _circleView.layer.borderColor = _borderColor.CGColor;
                
            } else {
                
                _backgroundView.backgroundColor = defaultBorderColor;
                
                _circleView.layer.borderColor = defaultBorderColor.CGColor;
                
            }
            
            _circleView.frame = CGRectMake(1, 1, _circleView.frame.size.width, _circleView.frame.size.height);
            
            _on = NO;
            
            _contentView.frame = CGRectMake(0, 0, _backgroundView.frame.size.width, _backgroundView.frame.size.height);
            
        }
        
        [self setNeedsLayout];

    }
}


@end
