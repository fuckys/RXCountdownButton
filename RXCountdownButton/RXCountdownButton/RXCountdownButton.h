//
//  RXCountdownButton.h
//  RXCountdownButton
//
//  Created by Rolex on 2017/7/5.
//  Copyright © 2017年 insuny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RXCountdownButton;

typedef NSString * (^ChangeBlock)(RXCountdownButton *sender, int second);
typedef NSString * (^FinishBlock)(RXCountdownButton *sender, int second);

@interface RXCountdownButton : UIButton
{
    ChangeBlock _changeBlock;
    FinishBlock _finishBlock;
}

- (void)countStartWithSecond:(int)second didChangeBlock:(ChangeBlock)changeBlock didFinishBlock:(FinishBlock)finishBlock;

@end
