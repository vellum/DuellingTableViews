//
//  VLMTouchBeganRecognizer.h
//  DuellingTableViews
//
//  Created by David Lu on 1/6/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface VLMTouchBeganRecognizer : UIGestureRecognizer

@property (readwrite) CGPoint firsttouch;

@end
