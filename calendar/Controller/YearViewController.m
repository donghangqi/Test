//
//  YearViewController.m
//  calendar
//
//  Created by 董航琪 on 16/10/10.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import "YearViewController.h"
#import "dataCell.h"
#import "DateTool.h"

static NSString *dateCellIdentiofier = @"dataCell";

@interface YearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *backCollectionView;
@property (nonatomic,strong) DateTool *tool;
@property (nonatomic,strong) NSString *redday;
@property (nonatomic,strong) NSDate *currentDate;
@property (nonatomic,strong) NSDate *today;

@end

@implementation YearViewController

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

#pragma mark - init
- (void)initContentView {
    //collectionviewflowlayout
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(SCREENT_WIDTH/7.0, _backCollectionView.frame.size.height);
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    [_backCollectionView setCollectionViewLayout:flowlayout animated:YES];
    //注册cell
    [_backCollectionView registerNib:[UINib nibWithNibName:dateCellIdentiofier bundle:nil] forCellWithReuseIdentifier:dateCellIdentiofier];
    //ios 默认translucent为yes，设置后坐标的零点在（0，0），如果想设置成（0，64）的话，添加下面一行代码
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)initContentData {
    _tool = [[DateTool alloc]init];
    _today = [NSDate date];
    _currentDate = _today;
    if (_selectdate) {
        _currentDate = _selectdate;
    }
    _redday = [NSString stringWithFormat:@"%ld",[_tool GetDate:_today]];
    NSString *titledate = [NSString stringWithFormat:@"%ld-%ld-%ld",[_tool GetYear:_currentDate],[_tool GetMonth:_currentDate],[_tool GetDate:_currentDate]];
    self.title = titledate;
    
    /////
    NSString *s = [NSString stringWithFormat:@"%ld-%ld",[_tool GetMonth:_selectdate],[_tool GetDate:_currentDate]];
    NSLog(@"currentdate:%@",s);
}

- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(NextWeek)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_backCollectionView addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(LastWeek)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_backCollectionView addGestureRecognizer:swipRight];
}

#pragma mark - collection
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    dataCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:dateCellIdentiofier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.date.textColor = [UIColor blackColor];
    cell.dotview.hidden = YES;
    NSString *date = [NSString stringWithFormat:@"%ld",[_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])];
    //一个月的末尾连接下个月，需要计算下个月
    if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])>[_tool GetTotalDayOfTheMonth:_currentDate]) {
        NSDate *newdate = [_tool GetTodayOfTheNextMonth:_currentDate];
        NSInteger weekday = [_tool GetWeekdayOfFirstDay:newdate];
        NSString *date = [NSString stringWithFormat:@"%ld",indexPath.row-weekday+1];
        cell.date.text = date;
    //上个月的结尾，31号，连接上个月，需要计算上个月
    }else if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])==0) {
        NSDate *newdate = [_tool GetTodayOfTheLastMonth:_currentDate];
        NSString *date1 = [NSString stringWithFormat:@"%ld",[_tool GetTotalDayOfTheMonth:newdate]];
        cell.date.text = date1;
    //上个月的结尾，30号
    }else if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])==-1){
        NSDate *newdate = [_tool GetTodayOfTheLastMonth:_currentDate];
        NSString *date1 = [NSString stringWithFormat:@"%ld",[_tool GetTotalDayOfTheMonth:newdate]-1];
        cell.date.text = date1;
        
    }else if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])==-2) {
        NSDate *newdate = [_tool GetTodayOfTheLastMonth:_currentDate];
        NSString *date1 = [NSString stringWithFormat:@"%ld",[_tool GetTotalDayOfTheMonth:newdate]-2];
        cell.date.text = date1;
    }else if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])==-3) {
        NSDate *newdate = [_tool GetTodayOfTheLastMonth:_currentDate];
        NSString *date1 = [NSString stringWithFormat:@"%ld",[_tool GetTotalDayOfTheMonth:newdate]-3];
        cell.date.text = date1;
    }else if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])==-4) {
        NSDate *newdate = [_tool GetTodayOfTheLastMonth:_currentDate];
        NSString *date1 = [NSString stringWithFormat:@"%ld",[_tool GetTotalDayOfTheMonth:newdate]-4];
        cell.date.text = date1;
    }else if ([_tool GetDate:_currentDate]+(indexPath.row - [_tool GetWeekdayOfToday:_currentDate])==-5) {
        NSDate *newdate = [_tool GetTodayOfTheLastMonth:_currentDate];
        NSString *date1 = [NSString stringWithFormat:@"%ld",[_tool GetTotalDayOfTheMonth:newdate]-5];
        cell.date.text = date1;
    }
    else {
        cell.date.text = date;
        
    }

    //选中的日期
    NSString *selectdate = [NSString stringWithFormat:@"%ld",[_tool GetDate:_selectdate]];
    if (_selectdate == _currentDate) {
        if (cell.date.text == selectdate) {
            [cell initContentView:_isselected];
        }
    }
    //当前周
    if ([_tool GetYear:_currentDate] == [_tool GetYear:_today] && [_tool GetMonth:_currentDate] == [_tool GetMonth:_today] ) {
        if (cell.date.text == _redday) {
            cell.date.textColor = [UIColor redColor];
        }
    }
    return cell;
}

- (IBAction)NextWeek {
    [UIView transitionWithView:_backCollectionView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        _currentDate = [_tool GetTheDateOfNextWeek:_currentDate];

        NSString *titledate = [NSString stringWithFormat:@"%ld-%ld-%ld",[_tool GetYear:_currentDate],[_tool GetMonth:_currentDate],[_tool GetDate:_currentDate]];
        self.title = titledate;
        [_backCollectionView reloadData];
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)LastWeek {
    [UIView transitionWithView:_backCollectionView duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        _currentDate = [_tool GetTheDateOfLastWeek:_currentDate];

        NSString *titledate = [NSString stringWithFormat:@"%ld-%ld-%ld",[_tool GetYear:_currentDate],[_tool GetMonth:_currentDate],[_tool GetDate:_currentDate]];
        self.title = titledate;
        [_backCollectionView reloadData];
    } completion:^(BOOL finished) {
        
    }];

    
}

@end
