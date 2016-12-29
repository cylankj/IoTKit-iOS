//
//  FLProgressHUDRingIndicatorView.h
//  FLProgressHUD
//
//  Created by cylan on 15/8/21.
//  Copyright (c) 2015年 FL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLProgressHUDRingIndicatorView : UIView
@property (nonatomic,strong)UIColor *backgroungRingColor;
@property (nonatomic,strong)UIColor *forwardRingColor;
@property (nonatomic,assign)CGFloat progress;
@end
