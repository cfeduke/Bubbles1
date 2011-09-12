//
//  Bubbles1ViewController.h
//  Bubbles1
//
//  Created by Eric Freeman on 3/14/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface Bubbles1ViewController : UIViewController 
{
    AVAudioPlayer *player;
}
-(void)preparePopSound;
-(void)makePopSound;
@end

