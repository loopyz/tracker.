//
//  TRHomeViewController.m
//  tracker.
//
//  Created by Lucy Guo on 8/24/14.
//  Copyright (c) 2014 Ludo Labs, Inc. All rights reserved.
//

#import "TRHomeViewController.h"
#import "KLCPopup.h"
#import "TRStartEndPeriod.h"
#import "TRTimeLeftView.h"
#import "TRFertilizationView.h"
#import "TRLastMonthFlow.h"
#import "TRLastMonthPainView.h"
#import "TRTodayFlowView.h"
#import "TRTodayPainView.h"
#import "TRSetTodaysFlowView.h"
#import "TRSetTodaysPainView.h"
#import "TRSettingsViewController.h"
#import "TRCustomCellTableViewCell.h"

static const int kStatusViewHeight = 52;
static const int cellHeight = 68;

@interface TRHomeViewController () {
    UIColor *bgColor;
    TRStartEndPeriod *statusView;
    TRTimeLeftView *timeLeftView;
    TRLastMonthFlow *lastMonthFlowView;
    TRLastMonthPainView *lastMonthPainView;
    TRFertilizationView *fertilizationView;
    TRTodayFlowView *todayFlowView;
    TRTodayPainView *todayPainView;
    TRSetTodaysFlowView *setTodaysFlowView;
    TRSetTodaysPainView *setTodaysPainView;
    UILabel *status;
    KLCPopup* popup;
    BOOL periodStarted;
}
@property (nonatomic, retain) NSDate * curDate;
@property (nonatomic, retain) NSDateFormatter * formatter;
@end

@implementation TRHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initNavBar];
        [self setupStatusView];
        [self setupTimeLeftView];
        [self setupFertilizationView];
        [self setupLastMonthViews];
        [self setupTodaysViews];
        [self setupTags];
        
        // autoend period if neccessary
        if ([TRUtil shouldAutoEndPeriod]) {
            NSLog(@"autoending period now");
            [TRUtil addPastPeriod:nil];
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        periodStarted = ([defaults objectForKey:kTRPreviousPeriodEndDateKey] != nil);
        [self updateAllSubViews];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setupTags
{
    statusView.tag = 1;
    timeLeftView.tag = 1;
    lastMonthPainView.tag = 1;
    lastMonthFlowView.tag = 1;
    fertilizationView.tag = 1;
    todayPainView.tag = 1;
    todayFlowView.tag = 1;
//    setTodaysFlowView.tag = 1;
//    setTodaysPainView.tag = 1;
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
    
    rbb.tintColor = [TRColors navTint];
    self.navigationItem.rightBarButtonItem = rbb;
    
}

- (void)settingsTouched
{
    TRSettingsViewController *settingsVC = [[TRSettingsViewController alloc] initWithNibName:nil bundle:nil];
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

- (void)setupTodaysViews
{
    todayFlowView = [[TRTodayFlowView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
    todayPainView = [[TRTodayPainView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
    setTodaysFlowView = [[TRSetTodaysFlowView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height - 200, self.tableView.frame.size.width, 200)];
    setTodaysPainView = [[TRSetTodaysPainView alloc] initWithFrame:CGRectMake(0, self.tableView.frame.size.height - 200, self.tableView.frame.size.width, 200)];
    setTodaysPainView.delegate = self;
    setTodaysFlowView.delegate = self;
}

- (void)setupLastMonthViews
{
    lastMonthFlowView = [[TRLastMonthFlow alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
    lastMonthPainView = [[TRLastMonthPainView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
}

- (void)setupFertilizationView
{
    fertilizationView = [[TRFertilizationView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
}

- (void)setupTimeLeftView
{
    timeLeftView = [[TRTimeLeftView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
}

- (void)setupStatusView
{
    statusView = [[TRStartEndPeriod alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kStatusViewHeight)];
}

- (void)startPeriodTouched:(NSDate *)date
{
    periodStarted = YES;
    NSLog(@"dat e%@", date);
    [TRUtil addCurrentPeriod:date];

    [self updateAllSubViews];
}

- (void)endPeriodTouched:(NSDate *)date
{
    periodStarted = NO;
    [TRUtil addPastPeriod:date];
    [self updateAllSubViews];
}

- (void)updateAllSubViews
{
    // get and process data from nsuserdefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // update status view
    [statusView refreshView:periodStarted];
    
    // update time left view
    NSDate *startDate = [defaults objectForKey:kTRCurrentPeriodStartDateKey];
    NSDate *nextDate = [defaults objectForKey:kTRNextPeriodStartDateKey];
    NSInteger currentPeriodTimeLeft = 0;
    NSInteger currentPeriodCurrentDay = 0;
    if (startDate != nil) {
        NSInteger currentPeriodDuration = [defaults integerForKey:kTRNextPeriodDurationKey];
        currentPeriodDuration = (currentPeriodDuration == 0) ? kTRDefaultPeriodDuration : currentPeriodDuration;
        currentPeriodTimeLeft = [TRUtil daysBetween:[NSDate date] and:[startDate dateByAddingTimeInterval:kTRDefaultDayTimeInterval*currentPeriodDuration]] - 1;
        currentPeriodCurrentDay = currentPeriodDuration - currentPeriodTimeLeft;
    } else if (nextDate != nil) {
        currentPeriodTimeLeft = [TRUtil daysBetween:[NSDate date] and:nextDate];
    }

    [timeLeftView refreshView:currentPeriodCurrentDay remaining:currentPeriodTimeLeft];
    
    // update fertilization view
    [fertilizationView refreshView:[TRUtil computeFertility]];

    // update last month views
    [lastMonthFlowView refreshView:[defaults stringForKey:kTRPreviousPeriodFlowKey]];
    [lastMonthPainView refreshView:[defaults stringForKey:kTRPreviousPeriodPainKey]];
    
    // update current period views
    [todayFlowView refreshView:[defaults stringForKey:kTRCurrentPeriodFlowKey]];
    [todayPainView refreshView:[defaults stringForKey:kTRCurrentPeriodPainKey]];
    
    // reload table
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (periodStarted) {
        return 8;
    } else {
        return 6; // hide today's pain and flow views
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return kStatusViewHeight;
    else if (indexPath.row == 5) return 20;
    return cellHeight;
}

//for each cell in table
- (TRCustomCellTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRCustomCellTableViewCell *cell;
    NSString *startEndPeriodCell = @"StartEndPeriod";
    NSString *timeLeftCell = @"TimeLeft";
    NSString *fertilizationCell = @"Fertilization";
    NSString *lastMonthFlowCell = @"LastMonthFlow";
    NSString *lastMonthPainCell = @"LastMonthPain";
    NSString *gapCell = @"Gap";
    NSString *todayFlowCell = @"TodayFlow";
    NSString *todayPainCell = @"TodayPain";
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:startEndPeriodCell];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:timeLeftCell];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:fertilizationCell];
    } else if (indexPath.row == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:lastMonthFlowCell];
    } else if (indexPath.row == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:lastMonthPainCell];
    } else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:gapCell];
    } else if (indexPath.row == 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:todayFlowCell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:todayPainCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:startEndPeriodCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:statusView];
        }
        else if (indexPath.row == 1) {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:timeLeftCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:timeLeftView];
        }
        else if (indexPath.row == 2) {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fertilizationCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:fertilizationView];
        }
        else if (indexPath.row == 3) {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastMonthFlowCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:lastMonthFlowView];
        }
        else if (indexPath.row == 4) {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastMonthPainCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:lastMonthPainView];
        }
        // GAP ROW
        else if(indexPath.row == 5) {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gapCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        else if(indexPath.row == 6){
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:todayFlowCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:todayFlowView];
            
        } else {
            cell = [[TRCustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:todayPainCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:todayPainView];
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
