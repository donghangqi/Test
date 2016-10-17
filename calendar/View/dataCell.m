//
//  dataCell.m
//  calendar
//
//  Created by 董航琪 on 16/10/9.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import "dataCell.h"

@implementation dataCell
- (void)initContentView:(BOOL)selected {
    self.layer.masksToBounds = YES;
    if (selected==YES) {
        self.backgroundColor = [UIColor grayColor];
        self.date.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.date.textColor = [UIColor blackColor];
    }
}
@end
