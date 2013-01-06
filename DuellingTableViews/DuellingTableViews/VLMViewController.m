//
//  VLMViewController.m
//  DuellingTableViews
//
//  Created by David Lu on 1/4/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

// TODO: TouchBegin anywhere should halt scrolling
// TODO: Tap Statusbar to scroll to top
// TODO: Pan gesture recco resizes views

// TODO: TouchBegin any cell tilts
// TODO: Tap left side of cell to toggle selection, activate menu

#pragma mark -

#import "VLMViewController.h"
#define HEADER_HEIGHT 50
#define HOZ_TV_HEIGHT 150
#define HOZ_TVC_WIDTH 150
#define VER_TVC_HEIGHT 75
#define GUTTER 7
#define LABEL_TAG 10001
#define ITEM_COUNT 100
//#define DEBUG_GRID

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
    self.view.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:0.9 alpha:1.0];
    
#ifdef DEBUG_GRID
    for ( int i = 0; i < self.view.bounds.size.height; i+= 15 ){
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, i, self.view.bounds.size.width, 1)];
        [v setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.1f]];
        [self.view addSubview: v];
    }
    for ( int i = 0; i < self.view.bounds.size.width; i+= 10 ){
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(i, 0, 1, self.view.bounds.size.height)];
        [v setBackgroundColor:[UIColor colorWithWhite:0.2f alpha:0.1f]];
        [self.view addSubview: v];
    }
#endif
    
    [self setupHorizontalView];
    [self setupVerticalView];
    
    
    CGSize curSize = self.view.bounds.size;
    CGRect labelRect		= CGRectMake(0, 0, curSize.width, HEADER_HEIGHT);
    UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
    label.textColor			= [UIColor colorWithWhite:1.0f alpha:1.0f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.font				= [UIFont boldSystemFontOfSize:24];
    label.text = @"All Items";
    label.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.2f];
    label.shadowOffset = CGSizeMake(0, 1);
    [self.view addSubview:label];

}

#pragma mark -
#pragma mark EasyTableView Initialization

- (void)setupHorizontalView {
    CGSize curSize = self.view.bounds.size;
    
    CGRect frameRect = CGRectMake(0, HEADER_HEIGHT, curSize.width, HOZ_TV_HEIGHT);
    NSInteger NUM_OF_CELLS = ITEM_COUNT;
    UIColor *TABLE_BACKGROUND_COLOR = [UIColor clearColor];
    
	EasyTableView *view	= [[EasyTableView alloc] initWithFrame:frameRect numberOfColumns:NUM_OF_CELLS ofWidth:HOZ_TVC_WIDTH];
	self.horizontalView = view;
	
	horizontalView.delegate						= self;
	horizontalView.tableView.backgroundColor	= TABLE_BACKGROUND_COLOR;
	horizontalView.tableView.allowsSelection	= YES;
	horizontalView.tableView.separatorColor		= [UIColor clearColor];
	horizontalView.cellBackgroundColor			= [UIColor clearColor];
	[self.view addSubview:horizontalView];
}



- (void)setupVerticalView {
    CGSize curSize = self.view.bounds.size;
    
    CGRect frameRect = CGRectMake(0, HEADER_HEIGHT + HOZ_TV_HEIGHT+GUTTER, curSize.width, curSize.height - HOZ_TV_HEIGHT - HEADER_HEIGHT - GUTTER);
    NSInteger NUM_OF_CELLS = ITEM_COUNT;
    UIColor *TABLE_BACKGROUND_COLOR = [UIColor clearColor];
    
	EasyTableView *view	= [[EasyTableView alloc] initWithFrame:frameRect numberOfRows:NUM_OF_CELLS ofHeight:VER_TVC_HEIGHT];
	self.verticalView = view;
    
	verticalView.delegate					= self;
	verticalView.tableView.backgroundColor	= TABLE_BACKGROUND_COLOR;
	verticalView.tableView.allowsSelection	= YES;
	verticalView.tableView.separatorColor	= [UIColor clearColor];
	verticalView.cellBackgroundColor		= [UIColor clearColor];
    verticalView.autoresizingMask			= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	[self.view addSubview:verticalView];
}

#pragma mark -
#pragma mark EasyTableViewDelegate

// These delegate methods support both example views - first delegate method creates the necessary views

- (UIView *)easyTableView:(EasyTableView *)easyTableView viewForRect:(CGRect)rect {
    
    CGFloat m = 10.0f;
    CGFloat b = 4.0f;

    if (easyTableView == self.horizontalView) {
        UIView *retview = [[UIView alloc] initWithFrame:CGRectMake (m, 0, rect.size.width-m, rect.size.height-m)];
        [retview setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.0325f]];

        UIView *whiteview = [[UIView alloc] initWithFrame:CGRectMake(b, b, retview.frame.size.width-b*2, retview.frame.size.height-b*2)];
        [whiteview setBackgroundColor:[UIColor whiteColor]];
        [retview addSubview:whiteview];
        
        UIImageView *marker = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 41, 55)];
        [marker setImage:[UIImage imageNamed:@"marker_top.png"]];
        [marker setAlpha:1.0f];
        [retview addSubview:marker];
        
        CGRect labelRect		= CGRectMake(b, b, 17, 21);
        UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
        label.textColor			= [UIColor colorWithWhite:1.0f alpha:1.0f];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font				= [UIFont boldSystemFontOfSize:14];
        label.tag = LABEL_TAG;
        //label.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.25f];
        //label.shadowOffset = CGSizeMake(0, 1);

        [retview addSubview:label];
        return retview;

    } else {
        //UIView *retview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, rect.size.width-30, rect.size.height-1)];
        UIView *retview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [retview setBackgroundColor:[UIColor clearColor]];//colorWithWhite:1.0f alpha:1.0f]];
        
        UIImageView *marker = [[UIImageView alloc] initWithFrame:CGRectMake(m, 0, 41, 55)];
        [marker setImage:[UIImage imageNamed:@"marker_bottom.png"]];
        [retview addSubview:marker];
        
        /*
        for ( int i = 3; i < VER_TVC_HEIGHT; i+= 15 ){
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, i, rect.size.width, 0.25)];
            [v setBackgroundColor:[UIColor redColor]];
            [retview addSubview: v];
        }*/
        

        CGRect labelRect		= CGRectMake(m+5, 7, 17, 25);
        UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
        label.textColor			= [UIColor darkGrayColor];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font				= [UIFont boldSystemFontOfSize:14];
        label.tag = LABEL_TAG;
        label.shadowColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0, 1);
        [retview addSubview:label];


        labelRect		= CGRectMake(50, 6.5, rect.size.width-80, 22);
        UILabel *label2			= [[UILabel alloc] initWithFrame:labelRect];
        label2.textColor			= [UIColor colorWithWhite:0.2 alpha:0.9];
        label2.backgroundColor = [UIColor clearColor];
        label2.font				= [UIFont boldSystemFontOfSize:21];//[UIFont fontWithName:@"Courier" size:18];
        label2.text = @"Make, Model, Item";
        label2.shadowColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
        label2.shadowOffset = CGSizeMake(0, 1);

        [retview addSubview:label2];

        labelRect		= CGRectMake(50, 10+18, rect.size.width-80, 40);
        UILabel *label3			= [[UILabel alloc] initWithFrame:labelRect];
        label3.textColor			= [UIColor colorWithWhite:0.2f alpha:0.425f];
        label3.backgroundColor = [UIColor clearColor];
        label3.font				= [UIFont systemFontOfSize:13];//[UIFont fontWithName:@"Courier" size:13];
        label3.numberOfLines = 2;
        label3.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas aliquam vulputate rutrum. Cras ut tincidunt lacus. Vestibulum sit amet tristique mi.";
        label3.shadowColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
        label3.shadowOffset = CGSizeMake(0, 1);

        [retview addSubview:label3];

        
        return retview;
    }
}
- (UIView*)easyTableView:(EasyTableView*)easyTableView viewForFooterInSection:(NSInteger)section{
    CGSize curSize = self.view.bounds.size;
    CGRect frameRect = ( easyTableView == self.verticalView ) ?
        CGRectMake(0, 0, curSize.width, curSize.height - HEADER_HEIGHT - HOZ_TV_HEIGHT - VER_TVC_HEIGHT ) :
        CGRectMake(0, 0, curSize.width - HOZ_TVC_WIDTH, HOZ_TV_HEIGHT );
    UIView *ret = [[UIView alloc] initWithFrame:frameRect];
    [ret setBackgroundColor:[UIColor clearColor]];
    return ret;
}

// Second delegate populates the views with data from a data source

- (void)easyTableView:(EasyTableView *)easyTableView setDataForView:(UIView *)view forIndexPath:(NSIndexPath *)indexPath {
	UILabel *label	= (UILabel *)[view viewWithTag:LABEL_TAG];
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
        if ( index > ITEM_COUNT-1 ) index = ITEM_COUNT-1;
        
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
