//
//  DataViewController.m
//  calendar
//
//  Created by 董航琪 on 16/10/9.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import "DataViewController.h"
#import "dataCell.h"
#import "YearViewController.h"

//#define TMCache @"ID";

static NSString *dateCellIdentifier = @"dataCell";
static NSString *tmcacheCellIdentifier = @"tmcacheCell";
@interface DataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *backCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *backTableView;
@property (nonatomic,strong) DateTool *tool;
@property (nonatomic,strong) NSDate *currentdate;
@property (nonatomic,assign) NSInteger daycount;
@property (nonatomic,strong) NSDate *today;
@property (nonatomic,strong) NSString *redday;
//@property (nonatomic,assign) BOOL isselect;

@end


@implementation DataViewController{
    NSString *selectday;
    NSMutableDictionary *flagdic;
    dataCell *oldcell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentData];
    [self initContentView];
    [self addSwipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContentView {

    UICollectionViewFlowLayout *collectionFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionFlowLayout.minimumLineSpacing = 0;
    collectionFlowLayout.minimumInteritemSpacing = 0;
    collectionFlowLayout.itemSize = CGSizeMake(SCREENT_WIDTH/7.0, (_backCollectionView.frame.size.height-64-44)/7);
    [_backCollectionView setCollectionViewLayout:collectionFlowLayout animated:YES];
    [_backCollectionView registerNib:[UINib nibWithNibName:dateCellIdentifier bundle:nil] forCellWithReuseIdentifier:dateCellIdentifier];
    //导航栏标题
    NSString *titledate = [NSString stringWithFormat:@"%ld-%ld",[_tool GetYear:_currentdate],[_tool GetMonth:_currentdate]];
    self.title = titledate;
    
    [_backTableView registerNib:[UINib nibWithNibName:tmcacheCellIdentifier bundle:nil] forCellReuseIdentifier:tmcacheCellIdentifier];

}

- (void)initContentData {
    _tool = [[DateTool alloc]init];
    
    //今天的日期
    _currentdate = [NSDate date];
    _today = _currentdate;
    _redday = [NSString stringWithFormat:@"%ld",[_tool GetDate:_today]];
//    _isselect = YES;
    
    //事件标志
    NSString *flag = @"2016-10-11";
    flagdic = [NSMutableDictionary new];
    [flagdic setObject:@"1" forKey:flag];
    
    [[TMCache sharedCache]setObject:@"1" forKey:flag];
}

#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_tool GetTotalDayOfTheMonth:_currentdate]+[_tool GetWeekdayOfFirstDay:_currentdate];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    dataCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dateCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.date.textColor = [UIColor blackColor];
    cell.dotview.hidden = YES;
    //这个月有几天
    NSInteger daycount = [_tool GetTotalDayOfTheMonth:_currentdate];
    //第一天是星期几
    NSInteger firstweekday = [_tool GetWeekdayOfFirstDay:_currentdate];
    //show
    if (indexPath.row<firstweekday || indexPath.row>firstweekday+daycount-1) {
        cell.date.text = @"";
    }else{
        NSString *day = [NSString stringWithFormat:@"%ld",indexPath.row-firstweekday+1];
        cell.date.text = day;
        if ([_tool GetMonth:_currentdate] == [_tool GetMonth:_today] && [_tool GetYear:_currentdate] == [_tool GetYear:_today] ) {
            if (cell.date.text == _redday) {
                cell.date.textColor = [UIColor redColor];
                cell.backgroundColor = [UIColor whiteColor];
            }
        }else {
            cell.date.textColor = [UIColor grayColor];
        }
    }
    NSString *date = [NSString stringWithFormat:@"%ld-%ld-%@",[_tool GetYear:_currentdate],[_tool GetMonth:_currentdate],cell.date.text];
    if ([self haveEvent:date] == YES) {
        NSLog(@"show dot!");
        cell.dotview.hidden = NO;
    }
    

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    dataCell *cell  = (dataCell *)[collectionView cellForItemAtIndexPath:indexPath];
    selectday = cell.date.text;
//    [cell initContentView:_isselect];
//    _isselect = !_isselect;
    oldcell.backgroundColor = [UIColor whiteColor];
    oldcell.date.textColor = [UIColor blackColor];
    if (oldcell.date.text == _redday) {
        oldcell.date.textColor = [UIColor redColor];
    }
    cell.backgroundColor = [UIColor grayColor];
    if (cell.date.text == _redday) {
        cell.date.textColor = [UIColor redColor];
    }else {
        cell.date.textColor = [UIColor whiteColor];
    }
    oldcell = cell;

    [self performSegueWithIdentifier:@"PushToWeek" sender:nil];
}
#pragma mark - IBActions
- (IBAction)LastMonth {

    [UIView transitionWithView:_backCollectionView duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _currentdate = [_tool GetTodayOfTheLastMonth:_currentdate];
        NSString *titledate = [NSString stringWithFormat:@"%ld-%ld",[_tool GetYear:_currentdate],[_tool GetMonth:_currentdate]];
        self.title = titledate;
    } completion:nil];
    [_backCollectionView reloadData];
}

- (IBAction)NextMonth {
    [UIView transitionWithView:_backCollectionView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        _currentdate = [_tool GetTodayOfTheNextMonth:_currentdate];
        NSString *titledate = [NSString stringWithFormat:@"%ld-%ld",[_tool GetYear:_currentdate],[_tool GetMonth:_currentdate]];
        self.title = titledate;
    } completion:nil];
    [_backCollectionView reloadData];

}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger firstweekday = [_tool GetWeekdayOfFirstDay:_currentdate];
    NSString *ID = [NSString stringWithFormat:@"%ld-%ld-%ld",[_tool GetYear:_currentdate],[_tool GetMonth:_currentdate],indexPath.row-firstweekday+1];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tmcacheCellIdentifier];
    if ((NSString *)[[TMCache sharedCache]objectForKey:ID]==nil) {
        cell.textLabel.text = @"无事件";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }else {
    cell.textLabel.text = (NSString *)[[TMCache sharedCache]objectForKey:ID];
    }
    return cell;
}

#pragma mark - push
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PushToWeek"] ) {
        YearViewController *week = segue.destinationViewController;
        NSString *newdateString = [NSString stringWithFormat:@"%ld-%ld-%@",[_tool GetYear:_currentdate],[_tool GetMonth:_currentdate],selectday];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *newdate = [formatter dateFromString:newdateString];
        week.selectdate = newdate;
        week.isselected = YES;

    }
}

#pragma mark - 判断日期是否有事件
- (BOOL)haveEvent:(NSString *)date {
//    if ([flagdic objectForKey:date]) {
//        NSLog(@"%@",[flagdic objectForKey:date]);
//        return YES;
//    }
//    else{
//        return NO;
//    }
    if ([[[TMCache sharedCache]objectForKey:date] isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}
#pragma mark - 手势
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(NextMonth)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_backCollectionView addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(LastMonth)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_backCollectionView addGestureRecognizer:swipRight];
}
@end
