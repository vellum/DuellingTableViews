//
//  VLMViewController.m
//  DuellingTableViews
//
//  Created by David Lu on 1/4/13.
//  Copyright (c) 2013 David Lu. All rights reserved.
//

#import "VLMViewController.h"
#define HOZ_TV_HEIGHT 150
#define HOZ_TVC_WIDTH 100
#define VER_TVC_HEIGHT 60

@interface VLMViewController ()
@property (nonatomic) CGPoint targetOffset;
@end

@implementation VLMViewController

@synthesize verticalView, horizontalView, targetOffset;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.targetOffset = CGPointMake(0, 0);
    
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
    
	EasyTableView *view	= [[EasyTableView alloc] initWithFrame:frameRect numberOfRows:NUM_OF_CELLS ofHeight:60.0f];
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
    
    if ( easyTableView == self.verticalView )
    {
        
        
        NSLog( @"%f", contentOffset.y );
        
        CGFloat index = contentOffset.y;
        if ( index < 0 )index = 0;
        index = floorf( index / VER_TVC_HEIGHT );
        
        //NSLog( @"%f", index );
        
        CGFloat equivalentOffset = index * HOZ_TVC_WIDTH;
        if ( self.targetOffset.x != equivalentOffset ){
            
            CGPoint p = self.targetOffset;
            p.x = equivalentOffset;
            self.targetOffset = p;
            [self.horizontalView setContentOffset:CGPointMake(equivalentOffset, 0.0f) animated:YES];
            
        }
        
        
    } else {
        
        
        NSLog( @"%f", contentOffset.x );
        CGFloat index = contentOffset.x;
        if ( index < 0 ) index = 0;
        index = floorf( index / HOZ_TVC_WIDTH );
        
        //NSLog( @"%f", index );
        
        CGFloat equivalentOffset = index * VER_TVC_HEIGHT;
        if ( self.targetOffset.y != equivalentOffset ){
            
            CGPoint p = self.targetOffset;
            p.y = equivalentOffset;
            self.targetOffset = p;
            [self.verticalView setContentOffset:CGPointMake(0.0f, equivalentOffset) animated:YES];
            
        }
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
