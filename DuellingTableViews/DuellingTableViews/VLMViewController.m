//
//  VLMViewController.m
//  DuellingTableViews
//
//  Created by David Lu on 1/4/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import "VLMViewController.h"
#define HEADER_HEIGHT 50
#define HOZ_TV_HEIGHT 150
#define HOZ_TVC_WIDTH 150
#define VER_TVC_HEIGHT 75
#define GUTTER 7
#define LABEL_TAG 10001

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
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    for ( int i = 0; i < self.view.bounds.size.height; i+= 15 ){
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, i, self.view.bounds.size.width, 0.25)];
        [v setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview: v];
    }
    
    [self setupHorizontalView];
    [self setupVerticalView];
    
}

#pragma mark -
#pragma mark EasyTableView Initialization

- (void)setupHorizontalView {
    CGSize curSize = self.view.bounds.size;
    
    CGRect frameRect = CGRectMake(0, HEADER_HEIGHT, curSize.width, HOZ_TV_HEIGHT);
    NSInteger NUM_OF_CELLS = 100;
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
    NSInteger NUM_OF_CELLS = 100;
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
        [retview setBackgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]];

        UIView *whiteview = [[UIView alloc] initWithFrame:CGRectMake(b, b, retview.frame.size.width-b*2, retview.frame.size.height-b*2)];
        [whiteview setBackgroundColor:[UIColor whiteColor]];
        [retview addSubview:whiteview];
        
        UIImageView *marker = [[UIImageView alloc] initWithFrame:CGRectMake(b, b, 19, 46)];
        [marker setImage:[UIImage imageNamed:@"marker_top.png"]];
        [retview addSubview:marker];
        
        CGRect labelRect		= CGRectMake(b, b, 17, 21);
        UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
        label.textColor			= [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font				= [UIFont boldSystemFontOfSize:14];
        label.tag = LABEL_TAG;
        [retview addSubview:label];
        return retview;

    } else {
        //UIView *retview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, rect.size.width-30, rect.size.height-1)];
        UIView *retview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [retview setBackgroundColor:[UIColor clearColor]];//colorWithWhite:1.0f alpha:1.0f]];
        
        UIImageView *marker = [[UIImageView alloc] initWithFrame:CGRectMake(m, 0, 39, 54)];
        [marker setImage:[UIImage imageNamed:@"marker_bottom.png"]];
        [retview addSubview:marker];
        
        /*
        for ( int i = 3; i < VER_TVC_HEIGHT; i+= 15 ){
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, i, rect.size.width, 0.25)];
            [v setBackgroundColor:[UIColor redColor]];
            [retview addSubview: v];
        }*/
        

        CGRect labelRect		= CGRectMake(m+4, 6, 17, 25);
        UILabel *label			= [[UILabel alloc] initWithFrame:labelRect];
        label.textColor			= [UIColor darkGrayColor];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.font				= [UIFont boldSystemFontOfSize:14];
        label.tag = LABEL_TAG;
        [retview addSubview:label];


        labelRect		= CGRectMake(55, 9, rect.size.width-75, 20);
        UILabel *label2			= [[UILabel alloc] initWithFrame:labelRect];
        label2.textColor			= [UIColor colorWithWhite:0.2 alpha:1.0];
        label2.backgroundColor = [UIColor clearColor];
        label2.font				= [UIFont fontWithName:@"Courier" size:18];
        label2.text = @"Apple Macbook Pro (2012)";
        [retview addSubview:label2];

        labelRect		= CGRectMake(55, 9+18, rect.size.width-75, 40);
        UILabel *label3			= [[UILabel alloc] initWithFrame:labelRect];
        label3.textColor			= [UIColor colorWithWhite:0.5 alpha:1.0];
        label3.backgroundColor = [UIColor clearColor];
        label3.font				= [UIFont fontWithName:@"Courier" size:13];
        label3.numberOfLines = 2;
        label3.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas aliquam vulputate rutrum. Cras ut tincidunt lacus. Vestibulum sit amet tristique mi.";
        [retview addSubview:label3];

        
        return retview;
    }
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
