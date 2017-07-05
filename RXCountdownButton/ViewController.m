//
//  ViewController.m
//  RXCountdownButton
//
//  Created by Rolex on 2017/7/5.
//  Copyright © 2017年 insuny. All rights reserved.
//

#import "ViewController.h"
#import "RXCountdownButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"RXCountdownButton";
    
    self.view.backgroundColor = [UIColor whiteColor];

    RXCountdownButton *btn = [RXCountdownButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 100, 150, 50)];
    [btn setCenter:self.view.center];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction:(RXCountdownButton *)sender {
    [sender countStartWithSecond:60 didChangeBlock:^NSString *(RXCountdownButton *sender, int second) {
        NSString *title = [NSString stringWithFormat:@"(%dS)", second];
        return title;
    } didFinishBlock:^NSString *(RXCountdownButton *sender, int second) {
        return @"重新获取验证码";
    }];
}

@end
