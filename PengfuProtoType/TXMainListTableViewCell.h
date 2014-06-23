//
//  TXMainListTableViewCell.h
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-12.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXPostsData.h"
#define HeadHeight 60
#define FootHeight 60
#define Margins 4

@interface TXMainListTableViewCell : UITableViewCell <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *lookCommentBtn;


- (void)setCellData:(TXPostsData *)data;
@end
