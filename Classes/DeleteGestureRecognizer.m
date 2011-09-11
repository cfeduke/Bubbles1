//
//  DeleteGestureRecognizer.m
//  Bubbles1
//
//  Created by Charles Feduke on 9/11/11.
//  Copyright 2011 Deployment Zone. All rights reserved.
//

#import "DeleteGestureRecognizer.h"

@implementation DeleteGestureRecognizer

@synthesize viewToDelete;

-(void)reset {
    [super reset];
    strokeMovingUp = YES;
    touchChangedDirection = 0;
    self.viewToDelete = nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) 
        return;
    
    CGPoint nowPoint = [[touches anyObject] locationInView:self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView:self.view];
    
    if (strokeMovingUp == YES) {
        if (nowPoint.y < prevPoint.y) {
            strokeMovingUp = NO;
            touchChangedDirection++;
        }
    } else if (nowPoint.y > prevPoint.y) {
        strokeMovingUp = YES;
        touchChangedDirection++;
    }
    
    if (viewToDelete == nil) {
        UIView *hit = [self.view hitTest:nowPoint withEvent:nil];
        if (hit != nil && hit != self.view)
            self.viewToDelete = hit;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.state != UIGestureRecognizerStatePossible) 
        return;
    
    self.state = touchChangedDirection >= 3 ? UIGestureRecognizerStateRecognized : UIGestureRecognizerStateFailed;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    [self reset];
    self.state = UIGestureRecognizerStateFailed;
}
@end
