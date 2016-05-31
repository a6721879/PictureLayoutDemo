//
//  CCPictureLayout.m
//  PictureLayoutDemo
//
//  Created by chengzi on 16/5/31.
//  Copyright © 2016年 Fosung. All rights reserved.
//
#define pictureHW (screenWidth - 5*padding)/4
#define MaxImageCount 9
#define deleImageWH 30 // 删除按钮的宽高
#define padding 10
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define imageTag 2000


#import "CCPictureLayout.h"

@interface CCPictureLayout ()

@property (strong, nonatomic) UIButton *addPictureButton;

@end

@implementation CCPictureLayout

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        self.picArray = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        [self addPicView];
    }
    
    return self;
}

- (void)addPicView {
    
    NSInteger imageCount = [self.picArray count];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + (i%4)*(pictureHW+padding), padding +(i/4)*(pictureHW+padding), pictureHW, pictureHW)];
        //用作放大图片
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView:)];
        [pictureImageView addGestureRecognizer:tap];
        
        //添加删除按钮
        UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
        dele.frame = CGRectMake(pictureHW - deleImageWH + 5, -10, deleImageWH, deleImageWH);
        [dele setImage:[UIImage imageNamed:@"deletePhoto"] forState:UIControlStateNormal];
        [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
        [pictureImageView addSubview:dele];
        
        pictureImageView.tag = imageTag + i;
        pictureImageView.userInteractionEnabled = YES;
        pictureImageView.image = [UIImage imageNamed:[self.picArray objectAtIndex:i]];
        [self addSubview:pictureImageView];
    }
    
    if (imageCount < MaxImageCount) {
        UIButton *addPictureButton = [[UIButton alloc]initWithFrame:CGRectMake(padding + (imageCount%4)*(pictureHW+padding), padding +(imageCount/4)*(pictureHW+padding), pictureHW, pictureHW)];
        [addPictureButton setBackgroundImage:[UIImage imageNamed:@"addPictures"] forState:UIControlStateNormal];
        [addPictureButton addTarget:self action:@selector(reloadPicture) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addPictureButton];
        self.addPictureButton = addPictureButton;
    }
    
    NSInteger headViewHeight = (10 + pictureHW)*([self.picArray count]/4 + 1);
    [UIView animateWithDuration:.2 animations:^{
        self.frame = CGRectMake(0, 0, screenWidth, headViewHeight);
    }];
}

#pragma mark - addPicture
- (void)reloadPicture {
    if (self.reloadPicBlock) {
        NSMutableArray *newsPicArray = self.reloadPicBlock();
        [self.picArray addObjectsFromArray:newsPicArray];
        [self addPicView];
    }
}

#pragma mark - gesture method
- (void)tapImageView:(UITapGestureRecognizer *)tap {
    if (self.selectPicBlock) {
        self.selectPicBlock(tap.view.tag);
    }
}

// 删除图片
- (void)deletePic:(UIButton *)btn {
    if ([(UIButton *)btn.superview isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)(UIButton *)btn.superview;
        [self.picArray removeObjectAtIndex:(imageView.tag - imageTag)];
        for (UIView *tmpView in self.subviews) {
            [tmpView removeFromSuperview];
        }
    }
    [self addPicView];
}

@end
