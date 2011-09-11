//
//  DeleteGestureRecognizer.h
//  Bubbles1
//
//  Created by Charles Feduke on 9/11/11.
//  Copyright 2011 Deployment Zone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface DeleteGestureRecognizer : UIGestureRecognizer {
    bool strokeMovingUp;
    int touchChangedDirection;
    UIView *viewToDelete;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)reset;

@property (nonatomic,retain) UIView *viewToDelete;
@end
