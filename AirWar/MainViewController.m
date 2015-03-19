//
//  MainViewController.m
//  AirWar
//
//  Created by locky1218 on 15-3-15.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import "MainViewController.h"
#import "LJSprite.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    drawView = [[MainView alloc] init];
    
    self.view = drawView;
    
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

//定时器事件
- (void)onTimer:(NSTimer *)sender
{
    //NSLog(@"this is timer!");
    //调整每个子弹的坐标
    //遍历每个子弹对象
    for(LJSprite * s in drawView.zidans)
    {
        s.y -= 5;
        if(s.y < 0)
        {
            s.isUsed = NO;
        }
    }
    
    //调整每个敌人的坐标
    //遍历每个敌人对象
    for(LJSprite * s in drawView.direns)
    {
        s.y += 5;
        if(s.y > [[UIScreen mainScreen] bounds].size.height)
        {
            s.isUsed = NO;
        }
    }
    
    
    
    static int cnt = 0;//记录次数，产生少一点的敌人
    cnt++;
    if(6 == cnt)
    {
        cnt = 0;
        //产生敌人
        int x = arc4random()%(320-10);//敌人的坐标
        //构建敌人对象
        LJSprite * dr = [[LJSprite alloc] init];
        dr.x = x;
        dr.y = -10;
        dr.isUsed = YES;
        
        //把敌人对象放到视图的敌人集合中
        [drawView.direns addObject:dr];
    }

    //碰撞检测!!!
    for(LJSprite * zd in drawView.zidans)
    {
        CGRect zdRect = CGRectMake(zd.x, zd.y, 17, 22);
        for(LJSprite * dr in drawView.direns)
        {
            CGRect drRect = CGRectMake(dr.x, dr.y, 40, 40 );
            if(true == CGRectIntersectsRect(zdRect, drRect))//敌人与子弹碰撞
            {
                zd.isUsed = NO;
                dr.isUsed = NO;
                LJSprite * bz = [[LJSprite alloc] init];
                bz.x = dr.x;
                bz.y = dr.y;
                bz.isUsed = YES;
                [drawView.baozhas addObject:bz];
            }

        }
        
    }
    
    
    //重绘
    [self.view setNeedsDisplay];
}

//触摸开始事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获得触摸对象
    UITouch * touch = [touches anyObject];//因为就一个对象，所以anyobject就可以了
    //得到触摸点坐标
    CGPoint p = [touch locationInView:self.view];
    
    drawView.ptZDJ = CGPointMake(p.x-49, p.y);
    
    if(p.y > 400)
    {
        //构建子弹对象
        LJSprite * zd = [[LJSprite alloc] init];
        zd.x = p.x;
        zd.y = p.y;
        zd.isUsed = YES;
        
        //把子弹对象放到视图的子弹集合中
        [drawView.zidans addObject:zd];
        
        [self.view setNeedsDisplay];//每次按钮都重新绘制
    }
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
