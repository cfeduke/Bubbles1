//
//  UIBubbleImageView.h
//  Bubbles1
//
//  Created by Charles Feduke on 9/12/11.
//  Copyright 2011 Deployment Zone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBubbleImageView : UIImageView {
    bool isPopped;
}
-(bool)pop;
@end
