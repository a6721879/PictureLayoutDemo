//
//  ViewController.m
//  PictureLayoutDemo
//
//  Created by chengzi on 16/5/31.
//  Copyright © 2016年 Fosung. All rights reserved.
//

#import "ViewController.h"
#import "CCPictureLayout.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CCPictureLayout *pivView = [[CCPictureLayout alloc] init];
    pivView.reloadPicBlock = ^{
        return @[@"default"].mutableCopy;
    };
    
    [self.view addSubview:pivView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
