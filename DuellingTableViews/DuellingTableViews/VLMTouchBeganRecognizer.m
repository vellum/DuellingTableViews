//
//  VLMTouchBeganRecognizer.m
//  DuellingTableViews
//
//  Created by David Lu on 1/6/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import "VLMTouchBeganRecognizer.h"

@implementation VLMTouchBeganRecognizer
@synthesize firsttouch;

- (void) reset
{
    [super reset];
    [self setFirsttouch:CGPointZero];
    [self setState:UIGestureRecognizerStatePossible];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count]>1) return;
    self.firsttouch = [[touches anyObject] locationInView:self.view];
    [super touchesBegan:touches withEvent:event];
    [self setState:UIGestureRecognizerStateBegan];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [self setState:UIGestureRecognizerStateFailed];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self setState:UIGestureRecognizerStateRecognized];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self setState:UIGestureRecognizerStateFailed];
}
@end
