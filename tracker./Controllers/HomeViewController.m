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
#import "FertilizationView.h"

static const int kStatusViewHeight = 52;
static const int cellHeight = 68;

@interface HomeViewController () {
    UIColor *bgColor;
    StartEndPeriod *statusView;
    TimeLeftView *timeLeftView;
    FertilizationView *fertilizationView;
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
        [self setupFertilizationView];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"searchicon.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchAddGameView)];
    
    lbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 99, 31.5)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav-logo.png"]];
    titleImageView.frame = CGRectMake(0, 5, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
    
    // Right bar button item to launch the categories selection screen.
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingsicon.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(settingsTouched)];
    
    rbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = rbb;
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
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

- (void)setupFertilizationView
{
    fertilizationView = [[FertilizationView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight) withFertilizationState:1];
    
}

- (void)setupTimeLeftView
{
    timeLeftView = [[TimeLeftView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight) isOnPeriod:YES];
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return kStatusViewHeight;
    return cellHeight;
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
        else if (indexPath.row == 2) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TimeLeft"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
        }
        
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor whiteColor];
            [cell addSubview:statusView];
        }
        else if (indexPath.row  == 1) {
            [cell addSubview:timeLeftView];
        }
        else if (indexPath.row == 2) {
            [cell addSubview:fertilizationView];
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
