//
//  ViewController.m
//  coreTextDemo
//
//  Created by LDY on 17/3/20.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "ViewController.h"
#import "DisplayView.h"
#import "CoreTextView.h"
@interface ViewController ()

@property(nonatomic,strong)DisplayView *displayView;

@property(nonatomic,strong)CoreTextView *coreTextView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor blueColor];
//    [scrollView addSubview:self.displayView];
    [scrollView addSubview:self.coreTextView];
    scrollView.contentSize =  CGSizeMake(kscreenWidth, 3*kscreenHeight);
//
    [self.view addSubview:scrollView];
//    [self.view addSubview:self.displayView];
//    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight)];
//    testView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:testView];
    
}

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
-(CoreTextView *)coreTextView{
    if (!_coreTextView) {
        _coreTextView = [[CoreTextView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, 3*kscreenHeight)];
        _coreTextView.backgroundColor = [UIColor lightGrayColor];
    }
    return _coreTextView;
}
@end
