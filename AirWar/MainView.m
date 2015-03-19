//
//  MainView.m
//  AirWar
//
//  Created by locky1218 on 15-3-15.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import "MainView.h"
#import "LJSprite.h"

@implementation MainView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"redraw rect!");
    /*子弹*/
    //保存要移除的子弹的集合
    NSMutableArray * arr = [[NSMutableArray alloc] initWithCapacity:100];
    //遍历子弹集合
    for(LJSprite * s in self.zidans)//!!!如果有10个，则删除掉一个的话，遍历到最后会找不到第十个，出问题,所以要先移除
    {
        //绘制子弹
        if(NO == s.isUsed)
        {
            //放到要移除的集合里
            [arr addObject:s];
        }
    }
    //移除无效的子弹
    [self.zidans removeObjectsInArray:arr];
    
    for(LJSprite * s in self.zidans)//!!!如果有10个，则删除掉一个的话，遍历到最后会找不到第十个，出问题
    {
        //绘制子弹
        if(s.isUsed)
        {
           [zidanImage drawAtPoint:CGPointMake(s.x, s.y)];
        }
    }
    
    /*敌人*/
    //保存要移除的敌人的集合
    NSMutableArray * arrdiren = [[NSMutableArray alloc] initWithCapacity:100];
    //遍历敌人集合
    for(LJSprite * s in self.direns)//!!!如果有10个，则删除掉一个的话，遍历到最后会找不到第十个，出问题,所以要先移除
    {
        //绘制敌人
        if(NO == s.isUsed)
        {
            //放到要移除的集合里
            [arrdiren addObject:s];
        }
    }
    //移除无效的敌人
    [self.direns removeObjectsInArray:arrdiren];
    
    for(LJSprite * s in self.direns)//!!!如果有10个，则删除掉一个的话，遍历到最后会找不到第十个，出问题
    {
        //绘制敌人
        if(s.isUsed)
        {
            [direnImage drawAtPoint:CGPointMake(s.x, s.y)];
        }
    }
    
    
    /*爆炸*/
    [arr removeAllObjects];
    for(LJSprite * s in self.baozhas)
    {
        if(NO == s.isUsed)
        {
            //放到要移除的集合里
            [arr addObject:s];
        }
    }
    [self.direns removeObjectsInArray:arr];
    
    for(LJSprite * s in self.baozhas)
    {
        if(s.isUsed)
        {
            [baozhaImage drawAtPoint:CGPointMake(s.x, s.y)];
            s.isUsed = NO;
        }
    }
    
    /*战斗机*/
    [zhandoujiImage drawAtPoint:CGPointMake(self.ptZDJ.x, self.ptZDJ.y)];
    
    NSLog(@"子弹总数=%d, 敌人总数=%d", [self.zidans count], [self.direns count]);
    
}


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor grayColor];
        
        //加载图片
        zidanImage = [UIImage imageNamed:@"zd.png"];
        direnImage = [UIImage imageNamed:@"dr.png"];
        baozhaImage = [UIImage imageNamed:@"bz.png"];
        zhandoujiImage = [UIImage imageNamed:@"nc.png"];
        //构建保存所有对象的集合
        self.zidans = [[NSMutableArray alloc] initWithCapacity:100];
        self.direns = [[NSMutableArray alloc] initWithCapacity:100];
        self.baozhas = [[NSMutableArray alloc] initWithCapacity:100];
        self.ptZDJ = CGPointMake(320/2-62/2, 550);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end
