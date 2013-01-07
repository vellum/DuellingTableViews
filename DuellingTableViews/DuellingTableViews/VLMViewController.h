//
//  VLMViewController.h
//  DuellingTableViews
//
//  Created by David Lu on 1/4/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyTableView.h"

@interface VLMViewController : UIViewController <EasyTableViewDelegate, UIGestureRecognizerDelegate> {
    
    EasyTableView *verticalView;
    EasyTableView *horizontalView;
    
}

@property (nonatomic, strong) EasyTableView *verticalView;
@property (nonatomic, strong) EasyTableView *horizontalView;

@end
