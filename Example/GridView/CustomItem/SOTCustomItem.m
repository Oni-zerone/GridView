//
//  CustomItem.m
//  GridView
//
//  Created by Andrea Altea on 12/12/16.
//  Copyright © 2016 Andrea Altea. All rights reserved.
//

#import "SOTCustomItem.h"

@implementation SOTCustomItem

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if(highlighted) {
        [UIView animateWithDuration:0.3 animations:^{
            [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.6, 0.6)];
        }];
    } else {
        [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
    
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.6 animations:^{
                [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2)];
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:1.0 animations:^{
                [self setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
            }];
            
        } completion:nil];
    }
}

@end
