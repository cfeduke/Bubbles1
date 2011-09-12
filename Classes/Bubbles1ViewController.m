//
//  Bubbles1ViewController.m
//  Bubbles1
//
//  Created by Eric Freeman on 3/14/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "Bubbles1ViewController.h"
#import "DeleteGestureRecognizer.h"
#import "UIBubbleImageView.h"

@implementation Bubbles1ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UITapGestureRecognizer *tapRecognizer = 
		[[UITapGestureRecognizer alloc] 
		 initWithTarget:self 
		 action:@selector(handleTapFrom:)];

	[tapRecognizer setNumberOfTapsRequired:1];
	[self.view addGestureRecognizer:tapRecognizer];
	[tapRecognizer release];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight | UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    DeleteGestureRecognizer *deleteRecognizer = [[DeleteGestureRecognizer alloc] initWithTarget:self action:@selector(handleDeleteFrom:)];
    [self.view addGestureRecognizer:deleteRecognizer];
    
    [swipeRecognizer requireGestureRecognizerToFail:deleteRecognizer];
    
    [deleteRecognizer release];
    [swipeRecognizer release];
    
    [self preparePopSound];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    for (UIView *subview in [self.view subviews]) {
        [subview removeFromSuperview];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.75];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    [UIView commitAnimations];
}

-(void)handleDeleteFrom:(DeleteGestureRecognizer *)recognizer {
    [recognizer.viewToDelete removeFromSuperview];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

/*
 In response to a tap gesture, show the image view appropriately then make it fade out in place.
 */
- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer {
	CGPoint location = [recognizer locationInView:self.view];
	
    UIView *hitView = [self.view hitTest:location withEvent:nil];
    if ([hitView isKindOfClass:[UIBubbleImageView class]]) {
        if ([(UIBubbleImageView *)hitView pop] == YES)
            [self makePopSound];
    }
    else
    {    
        CGRect rect = CGRectMake(location.x - 40, location.y - 40, 80.0f, 80.0f);
        UIBubbleImageView *image = [[UIBubbleImageView alloc] initWithFrame:rect];
        
        [self.view addSubview:image];
        
        [image release];
    }
}

- (void)dealloc {
    [super dealloc];
    if (player != nil)
        [player dealloc];
}

-(void)preparePopSound {
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/bubble.aif", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.numberOfLoops = 0;
}

-(void)makePopSound {
    [player play];
}

@end
