//
//  YearViewController.h
//  calendar
//
//  Created by 董航琪 on 16/10/10.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCDefines.h"

@interface YearViewController : UIViewController
@property (nonatomic,assign) BOOL isselected;
@property (nonatomic,strong) NSDate *selectdate;
@end
