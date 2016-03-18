//
//  ViewController.m
//  CJCSwitch
//
//  Created by Ashuro on 16/3/16.
//  Copyright © 2016年 Ashuro. All rights reserved.
//

#import "ViewController.h"
#import "CJCSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    CJCSwitch *demoView = [[CJCSwitch alloc] initWithFrame:CGRectMake(20, 70, 46, 23)];
    
    demoView.onText = @"开oioioio";
    //kasdflkjsjdfjlsdjlfjklsdjf
    demoView.offText = @"关jojoj";
    
    demoView.offColor = [UIColor redColor];
    
    demoView.onColor = [UIColor greenColor];
    
    demoView.borderColor = [UIColor yellowColor];
    
    demoView.onTextColor = [UIColor redColor];
    
    demoView.offTextColor = [UIColor greenColor];
    
//    demoView.on = YES;
    
    

    [self.view addSubview:demoView];
    
    
//    [demoView addTarget:self action:@selector(haha:) forControlEvents:UIControlEventValueChanged];

}

- (void) haha : (CJCSwitch *) sender {
    
    NSLog(@"%d",sender.on);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
