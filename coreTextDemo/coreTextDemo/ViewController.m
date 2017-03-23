//
//  ViewController.m
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "ViewController.h"
#import "DisplayView.h"
@interface ViewController ()

@property(nonatomic,strong)DisplayView *displayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollView addSubview:self.displayView];
    scrollView.contentSize =  CGSizeMake(kscreenWidth, 3*kscreenHeight);
    
    [self.view addSubview:scrollView];
    
}
/*
 
 ,
 {
 "color":"purpleColor",
 "name":"Snip20170221_5.png",
 "height":200,
 "width":200,
 "type":"img",
 "size":10,
 "fontName":"ArialMT",
 "lineSpace":18
 }
 
 {
 "color":"purpleColor",
 "name":"Snip20170317_5.png",
 "height":50,
 "width":50,
 "type":"img",
 "size":10,
 "fontName":"ArialMT",
 "lineSpace":18
 },
 
 ,*/
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//  
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(DisplayView *)displayView{
    if (!_displayView) {
        _displayView = [[DisplayView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, 3*kscreenHeight)];
//        _displayView = [[DisplayView alloc]init];
        _displayView.backgroundColor = [UIColor lightGrayColor];
    }
    return _displayView;
}

@end
