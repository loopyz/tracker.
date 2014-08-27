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
#import "LastMonthFlow.h"
#import "LastMonthPainView.h"
#import "TodayFlowView.h"
#import "TodayPainView.h"
#import "SetTodaysFlowView.h"
#import "SetTodaysPainView.h"
#import "SettingsViewController.h"

static const int kStatusViewHeight = 52;
static const int cellHeight = 68;

@interface HomeViewController () {
    UIColor *bgColor;
    StartEndPeriod *statusView;
    TimeLeftView *timeLeftView;
    LastMonthFlow *lastMonthFlowView;
    LastMonthPainView *lastMonthPainView;
    FertilizationView *fertilizationView;
    TodayFlowView *todayFlowView;
    TodayPainView *todayPainView;
    SetTodaysFlowView *setTodaysFlowView;
    SetTodaysPainView *setTodaysPainView;
    UILabel *status;
    KLCPopup* popup;
    BOOL periodStarted;
}
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // get and process data from nsuserdefaults
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        periodStarted = ([defaults objectForKey:kTRPreviousPeriodEndDateKey] != nil);
        
        [self initNavBar];
        [self setupStatusView];
        
        // autoend period if neccessary
        if ([TRUtil shouldAutoEndPeriod]) {
            NSLog(@"autoending period now");
            [TRUtil addPastPeriod:nil];
        }
        
        NSDate *startDate = [defaults objectForKey:kTRCurrentPeriodStartDateKey];
        NSDate *nextDate = [defaults objectForKey:kTRNextPeriodStartDateKey];
        NSInteger currentPeriodTimeLeft = 0;
        NSInteger currentPeriodCurrentDay = 0;
        if (startDate != nil) {
            NSInteger currentPeriodDuration = [defaults integerForKey:kTRNextPeriodDurationKey];
            currentPeriodTimeLeft = [TRUtil daysBetween:[NSDate date] and:[startDate dateByAddingTimeInterval:60*60*24*currentPeriodDuration]];
            currentPeriodCurrentDay = currentPeriodDuration - currentPeriodTimeLeft;
        } else if (nextDate != nil) {
            currentPeriodTimeLeft = [TRUtil daysBetween:[NSDate date] and:nextDate];
        }
        [self setupTimeLeftView:currentPeriodCurrentDay remaining:currentPeriodTimeLeft];
        
        // TODO: figure out fertility schedules
        [self setupFertilizationView:1];
        
        NSString *previousPeriodFlow = [defaults stringForKey:kTRPreviousPeriodFlowKey];
        NSString *previousPeriodPain = [defaults stringForKey:kTRPreviousPeriodPainKey];
        [self setupLastMonthViews:previousPeriodFlow pain:previousPeriodPain];

        NSString *currentPeriodFlow = [defaults stringForKey:kTRCurrentPeriodFlowKey];
        NSString *currentPeriodPain = [defaults stringForKey:kTRCurrentPeriodPainKey];
        [self setupTodaysViews:currentPeriodFlow pain:currentPeriodPain];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)initNavBar
{
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
    
    rbb.tintColor = [Colors navTint];
    self.navigationItem.rightBarButtonItem = rbb;
    
}

- (void)settingsTouched
{
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:settingsVC animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.curDate = [NSDate date];
    self.formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"dd/MM/yyyy --- HH:mm"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTodaysViews:(NSString *)flow pain:(NSString *)pain
{
    todayFlowView = [[TodayFlowView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
    todayPainView = [[TodayPainView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
    setTodaysFlowView = [[SetTodaysFlowView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height - 200, self.tableView.frame.size.width, 200)];
    setTodaysPainView = [[SetTodaysPainView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height - 200, self.tableView.frame.size.width, 200)];
    setTodaysPainView.delegate = self;
    setTodaysFlowView.delegate = self;
    
    if (pain) {
        todayPainView.selectionLabel.text = pain;
    }
    
    if (flow) {
        todayFlowView.selectionLabel.text = flow;
    }
}

- (void)setupLastMonthViews:(NSString *)flow pain:(NSString *)pain
{
    if (flow == nil) {
        flow = @"N/A";
    }
    
    if (pain == nil) {
        pain = @"N/A";
    }
    
    lastMonthFlowView = [[LastMonthFlow alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight) withFlow:flow];
    lastMonthPainView = [[LastMonthPainView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight) withPain:pain];
}

- (void)setupFertilizationView:(NSInteger)fertilizationState
{
    fertilizationView = [[FertilizationView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight) withFertilizationState:fertilizationState];
    
}

- (void)setupTimeLeftView:(NSInteger)currentDay remaining:(NSInteger)remaining
{
    // todo: first time using the app (currentDay and remaining are both 0)

    timeLeftView = [[TimeLeftView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight) isOnPeriod:periodStarted];
    
    if ((currentDay == 0) && (remaining == 0)) { // first time using app
        [timeLeftView setupNoPreviousData];
    } else if (currentDay == 0) { // period hasn't started yet
        [timeLeftView setupDaysUntilPeriod:remaining];
    } else { // period has started
        [timeLeftView setupCurrentDayOfPeriod:currentDay];
        [timeLeftView setupDaysLeftTillEnd:remaining];
    }
}

- (void)setupStatusView
{
    statusView = [[StartEndPeriod alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kStatusViewHeight)];
    
    // TODO: change background based on whether period is started or not
    statusView.backgroundColor = [Colors mainColor];
    
    // setup status label
    statusView.status.text = @"Tap to start period";
}

- (void)startPeriodTouched:(NSDate *)date
{
    statusView.status.text = @"Tap to end period";
    statusView.backgroundColor = [Colors endPeriodColor];
    periodStarted = YES;
    NSLog(@"dat e%@", date);
    [TRUtil addCurrentPeriod:date];
}

- (void)endPeriodTouched:(NSDate *)date
{
    statusView.status.text = @"Tap to start period";
    statusView.backgroundColor = [Colors mainColor];
    periodStarted = NO;
    [TRUtil addPastPeriod:date];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return kStatusViewHeight;
    else if (indexPath.row == 5) return 20;
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
        else if (indexPath.row == 3) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LastMonthFlow"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if (indexPath.row == 4) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LastMonthPain"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        // GAP ROW
        else if(indexPath.row == 5) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Gap"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
        else if (indexPath.row == 3) {
            [cell addSubview:lastMonthFlowView];
        }
        else if (indexPath.row == 4) {
            [cell addSubview:lastMonthPainView];
        }
        else if (indexPath.row == 6) {
            [cell addSubview:todayFlowView];
        }
        else if (indexPath.row == 7) {
            [cell addSubview:todayPainView];
        }
        else {
            
            
            
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.datePicker = [THDatePickerViewController datePicker];
        self.datePicker.date = [NSDate date];
        self.datePicker.delegate = self;
        [self.datePicker setAllowClearDate:NO];
        [self.datePicker setAutoCloseOnSelectDate:YES];
        [self.datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
        [self.datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
        
        [self.datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
            int tmp = (arc4random() % 30)+1;
            if(tmp % 5 == 0)
                return YES;
            return NO;
        }];
        [self presentSemiViewController:self.datePicker withOptions:@{
                                                                      KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                      KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                                      KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                      }];
    }
    // launches todays flow popup
    else if (indexPath.row == 6){
        popup = [KLCPopup popupWithContentView:setTodaysFlowView showType:KLCPopupShowTypeSlideInFromBottom dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
        
        KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                                   KLCPopupVerticalLayoutBottom);
        
        [popup showWithLayout:layout];
    }
    // launches todays pain popup
    else if (indexPath.row == 7) {
        popup = [KLCPopup popupWithContentView:setTodaysPainView showType:KLCPopupShowTypeSlideInFromBottom dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
        
        KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter,
                                                   KLCPopupVerticalLayoutBottom);
        
        [popup showWithLayout:layout];
    }
    

    
}

#pragma mark - date picker delegate methods
-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker{
    self.curDate = datePicker.date;
    if (!periodStarted)
        [self startPeriodTouched:self.curDate];
    else [self endPeriodTouched:self.curDate];
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker{
    //[self.datePicker slideDownAndOut];
    [self dismissSemiModalView];
}

#pragma mark - SetTodaysPainView delegate methods

- (void)setHighPain
{
    todayPainView.selectionLabel.text = kTRPainHigh;
    [popup dismiss:YES];
}

- (void)setLowPain
{
    todayPainView.selectionLabel.text = kTRPainLow;
    [popup dismiss:YES];
}

- (void)setMediumPain
{
    todayPainView.selectionLabel.text = kTRPainMedium;
    [popup dismiss:YES];
}

#pragma mark - SetTodaysFlowView delegate methods

- (void)setLightFlow
{
    todayFlowView.selectionLabel.text = kTRFlowLight;
    [popup dismiss:YES];
}

- (void)setMediumFlow
{
   todayFlowView.selectionLabel.text = kTRFlowMedium;
    [popup dismiss:YES];
}

- (void)setHeavyFlow
{
    todayFlowView.selectionLabel.text = kTRFlowHeavy;
    [popup dismiss:YES];
}



@end
