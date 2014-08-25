//
//  HomeViewController.m
//  tracker.
//
//  Created by Lucy Guo on 8/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "HomeViewController.h"
#import "KLCPopup.h"
#import "Colors.h"
#import "StartEndPeriod.h"
#import "TimeLeftView.h"

static const int kStatusViewHeight = 52;

@interface HomeViewController () {
    UIColor *bgColor;
    StartEndPeriod *statusView;
    TimeLeftView *timeLeftView;
    UILabel *status;
    BOOL periodStarted;
}

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // get period started info
        periodStarted = NO;
        [self initNavBar];
        [self setupStatusView];
        [self setupTimeLeftView];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)initNavBar
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTimeLeftView
{
    timeLeftView = [[TimeLeftView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 68) isOnPeriod:YES];
    [timeLeftView setupCurrentDayOfPeriod:7];
    [timeLeftView setupDaysLeftTillEnd:4];
}

- (void)setupStatusView
{
    statusView = [[StartEndPeriod alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kStatusViewHeight)];
    
    // TODO: change background based on whether period is started or not
    statusView.backgroundColor = [Colors mainColor];
    
    // setup status label
    statusView.status.text = @"Tap to start period";
}

- (void)startPeriodTouched
{
    statusView.status.text = @"Tap to end period";
    statusView.backgroundColor = [Colors endPeriodColor];
    periodStarted = YES;
}

- (void)endPeriodTouched
{
    statusView.status.text = @"Tap to start period";
    statusView.backgroundColor = [Colors mainColor];
    periodStarted = NO;
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return kStatusViewHeight;
    return 70;
}

//for each cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"Cell";
    UITableViewCell *cell;
    if (indexPath.row != 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"StartEndPeriod"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:@"StartEndPeriod"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 1) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeLeft"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        cell.layer.shadowColor = [[UIColor whiteColor] CGColor];
        cell.layer.shadowOpacity = 1.0;
        cell.layer.shadowRadius = 0;
        cell.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor whiteColor];
            [cell addSubview:statusView];
        }
        else if (indexPath.row  == 1) {
            [cell addSubview:timeLeftView];
        }
        else {
            
            
            
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (!periodStarted)
            [self startPeriodTouched];
        else
            [self endPeriodTouched];
    }
    else if (indexPath.row == 2){
//        KLCPopup* popup = [KLCPopup popupWithContentView:statusViewPopup showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeShrinkOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:YES];
//        
//        KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
//                                                   KLCPopupVerticalLayoutBelowNav);
//        
//        [popup showWithLayout:layout];
    }
    

    
}



@end
