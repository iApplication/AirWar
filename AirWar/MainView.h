//
//  MainView.h
//  AirWar
//
//  Created by locky1218 on 15-3-15.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
{
    UIImage * zidanImage;
    UIImage * direnImage;
    UIImage * baozhaImage;
    UIImage * zhandoujiImage;
}

@property (strong, nonatomic) NSMutableArray * zidans;

@property (strong, nonatomic) NSMutableArray * direns;

@property (strong, nonatomic) NSMutableArray * baozhas;

@property (assign, nonatomic) CGPoint ptZDJ;

@end
