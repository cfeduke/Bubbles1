//
//  UIBubbleImageView.m
//  Bubbles1
//
//  Created by Charles Feduke on 9/12/11.
//  Copyright 2011 Deployment Zone. All rights reserved.
//

#import "UIBubbleImageView.h"

@implementation UIBubbleImageView

- (id)initWithFrame:(CGRect)frame {
    [super initWithFrame:frame];
    
    [self setImage:[UIImage imageNamed:@"bubble.png"]];
    [self setUserInteractionEnabled:YES];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    [self addGestureRecognizer:pinchRecognizer];
    [pinchRecognizer release];
    
    isPopped = NO;
    
    return self;
}

-(void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer {
    CGFloat scale = [recognizer scale];
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    recognizer.view.transform = transform;
}

-(bool)pop {
    if (isPopped == YES)
        return NO;
    
    [self setImage:[UIImage imageNamed:@"popped.png"]];
    isPopped = YES;
    return YES;
}
@end
