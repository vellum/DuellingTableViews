//
//  VLMViewController.m
//  DuellingTableViews
//
//  Created by David Lu on 1/4/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import "VLMViewController.h"
#define HOZ_TV_HEIGHT 150
#define HOZ_TVC_WIDTH 150
#define VER_TVC_HEIGHT 50

@interface VLMViewController ()
@property (nonatomic) CGPoint targetOffset;
@property (nonatomic) BOOL ignoreScrolling;
@end

@implementation VLMViewController

@synthesize verticalView, horizontalView, targetOffset, ignoreScrolling;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.targetOffset = CGPointMake(0, 0);
    self.ignoreScrolling = NO;
    
    [self setupHorizontalView];
    [self setupVerticalView];
    
}

#pragma mark -
#pragma mark EasyTableView Initialization

- (void)setupHorizontalView {
    CGSize curSize = self.view.bounds.size;
    
    CGRect frameRect = CGRectMake(0, 0, curSize.width, HOZ_TV_HEIGHT);
    NSInteger NUM_OF_CELLS = 100;
    UIColor *TABLE_BACKGROUND_COLOR = [UIColor clearColor];
    
	EasyTableView *view	= [[EasyTableView alloc] initWithFrame:frameRect numberOfColumns:NUM_OF_CELLS ofWidth:HOZ_TVC_WIDTH];
	self.horizontalView = view;
	
	horizontalView.delegate						= self;
	horizontalView.tableView.backgroundColor	= TABLE_BACKGROUND_COLOR;
	horizontalView.tableView.allowsSelection	= YES;
	horizontalView.tableView.separatorColor		= [UIColor whiteColor];
	horizontalView.cellBackgroundColor			= [UIColor clearColor];
    
	[self.view addSubview:horizontalView];
}



- (void)setupVerticalView {
    CGSize curSize = self.view.bounds.size;
    
    CGRect frameRect = CGRectMake(0, HOZ_TV_HEIGHT, curSize.width, curSize.height - HOZ_TV_HEIGHT);
    NSInteger NUM_OF_CELLS = 100;
    UIColor *TABLE_BACKGROUND_COLOR = [UIColor clearColor];
    
	EasyTableView *view	= [[EasyTableView alloc] initWithFrame:frameRect numberOfRows:NUM_OF_CELLS ofHeight:VER_TVC_HEIGHT];
	self.verticalView = view;
    
	verticalView.delegate					= self;
	verticalView.tableView.backgroundColor	= TABLE_BACKGROUND_COLOR;
	verticalView.tableView.allowsSelection	= YES;
	verticalView.tableView.separatorColor	= [[UIColor blackColor] colorWithAlphaComponent:0.01];
	verticalView.cellBackgroundColor		= [UIColor clearColor];
    verticalView.autoresizingMask			= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	[self.view addSubview:verticalView];
}

#pragma mark -
#pragma mark EasyTableViewDelegate

// These delegate methods support both example views - first delegate method creates the necessary views

- (UIView *)easyTableView:(EasyTableView *)easyTableView viewForRect:(CGRect)rect {
    
    if (easyTableView == self.horizontalView) {
        CGRect labelRect		= CGRectMake(0, 0.0f, rect.size.width, rect.size.height+0.0f);
        UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
        label.textColor			= [UIColor whiteColor];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor redColor];
        label.font				= [UIFont boldSystemFontOfSize:60];
        return label;
    } else {
        CGRect labelRect		= CGRectMake(0, 0.0f, rect.size.width, rect.size.height);
        UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
        label.textColor			= [UIColor blackColor];
        label.backgroundColor = [UIColor whiteColor];
        label.font				= [UIFont boldSystemFontOfSize:60];
        return label;
        
    }
}

// Second delegate populates the views with data from a data source

- (void)easyTableView:(EasyTableView *)easyTableView setDataForView:(UIView *)view forIndexPath:(NSIndexPath *)indexPath {
	UILabel *label	= (UILabel *)view;
	label.text		= [NSString stringWithFormat:@"%i", indexPath.row];
}

// Optional delegate to track the selection of a particular cell

- (void)easyTableView:(EasyTableView *)easyTableView selectedView:(UIView *)selectedView atIndexPath:(NSIndexPath *)indexPath deselectedView:(UIView *)deselectedView {
    
    
}

- (void)easyTableView:(EasyTableView *)easyTableView scrolledToOffset:(CGPoint)contentOffset{
    
    if (easyTableView.isDragging) self.ignoreScrolling = NO;
    
    if ( easyTableView == self.verticalView ){
        CGFloat index = contentOffset.y;
        if ( index < 0 )index = 0;
        if ( easyTableView.isDragging )
            index = roundf( index / VER_TVC_HEIGHT );
        else
            index /= VER_TVC_HEIGHT;
        
        CGFloat equivalentOffset = index * HOZ_TVC_WIDTH;
        if ( self.targetOffset.x != equivalentOffset ){
            CGPoint p = self.targetOffset;
            p.x = equivalentOffset;
            self.targetOffset = p;
            if ( easyTableView.isDragging ){
                [self.horizontalView setContentOffset:CGPointMake(equivalentOffset, 0.0f) animated:YES];
            } else if (!self.ignoreScrolling) {
                [self.horizontalView setContentOffset:CGPointMake(equivalentOffset, 0.0f) animated:NO];
            }
        }
    } else {
    
        CGFloat index = contentOffset.x;
        if ( index < 0 ) index = 0;
        if ( easyTableView.isDragging )
            index = roundf( index / HOZ_TVC_WIDTH );
        else
            index /= HOZ_TVC_WIDTH;
        
        CGFloat equivalentOffset = index * VER_TVC_HEIGHT;
        if ( self.targetOffset.y != equivalentOffset ){
            CGPoint p = self.targetOffset;
            p.y = equivalentOffset;
            self.targetOffset = p;
            if ( easyTableView.isDragging ){
                [self.verticalView setContentOffset:CGPointMake(0.0f, equivalentOffset) animated:YES];
            } else if (!self.ignoreScrolling) {
                [self.verticalView setContentOffset:CGPointMake(0.0f, equivalentOffset) animated:NO];
            }
        }
    }

}

- (void)easyTableView:(EasyTableView *)easyTableView willEndDraggingWithVelocity:(CGFloat)velocity targetContentOffset:(CGFloat)targetContentOffset{
    
    // test if scrollview is already where it needs to be
    // if so, set a flag to ignore scrolling
    
    
        
    if ( easyTableView == self.verticalView )
        {
            CGFloat targetOffsetY = targetContentOffset;
            CGFloat index = roundf( targetOffsetY / VER_TVC_HEIGHT ); if ( index < 0 ){index = 0;}
            
            CGFloat contentOffsetX = self.horizontalView.tableView.contentOffset.y;
            CGFloat targetOffsetX = index * HOZ_TVC_WIDTH;
            if ( contentOffsetX == targetOffsetX ){
                self.ignoreScrolling = YES;
            }
            
        } else {
            CGFloat targetOffsetX = targetContentOffset;
            CGFloat index = roundf( targetOffsetX / HOZ_TVC_WIDTH ); if ( index < 0 ){index = 0;}
            
            CGFloat contentOffsetY = self.verticalView.tableView.contentOffset.y;
            CGFloat targetOffsetY = index * VER_TVC_HEIGHT;
            if ( contentOffsetY == targetOffsetY ){
                self.ignoreScrolling = YES;
            }
        }
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
