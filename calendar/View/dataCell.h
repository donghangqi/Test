//
//  dataCell.h
//  calendar
//
//  Created by 董航琪 on 16/10/9.
//  Copyright © 2016年 董航琪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dataCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIView *dotview;
- (void)initContentView:(BOOL)selected;
@end
