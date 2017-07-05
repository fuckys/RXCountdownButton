//
//  RXCountdownButton.m
//  RXCountdownButton
//
//  Created by Rolex on 2017/7/5.
//  Copyright © 2017年 insuny. All rights reserved.
//

#import "RXCountdownButton.h"

@interface RXCountdownButton ()
{
    int _second;
    int _totalSecond;
}
@end

@implementation RXCountdownButton

- (void)countStartWithSecond:(int)second didChangeBlock:(ChangeBlock)changeBlock didFinishBlock:(FinishBlock)finishBlock {
    _totalSecond = second;
    _second = second;
    
    _changeBlock = [changeBlock copy];
    _finishBlock = [finishBlock copy];
    
    [self startTime];
}

-(void)startTime{
    self.userInteractionEnabled = NO;
    __block int timeout = _totalSecond; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置 特别注明：UI的改变一定要在主线程中进行
                [self setTitle:_finishBlock(self, _second) forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            if (timeout == 60) {
                seconds = 60;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self setTitle:_changeBlock(self, _second) forState:UIControlStateNormal];
            });
            timeout--;
            _second--;
        }
    });
    dispatch_resume(_timer);
}

@end
