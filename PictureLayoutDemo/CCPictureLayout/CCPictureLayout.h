//
//  CCPictureLayout.h
//  PictureLayoutDemo
//
//  Created by chengzi on 16/5/31.
//  Copyright © 2016年 Fosung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPictureLayout : UIView


//picture array
@property (strong, nonatomic) NSMutableArray *picArray;

@property (copy, nonatomic) void(^selectPicBlock)(NSInteger index);

@property (copy, nonatomic) NSMutableArray *(^reloadPicBlock)();
@end
