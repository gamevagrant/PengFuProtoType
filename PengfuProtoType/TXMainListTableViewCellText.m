//
//  TXMainListTableViewCellText.m
//  PengfuProtoType
//
//  Created by 齐宇 on 14-6-20.
//  Copyright (c) 2014年 tiexue. All rights reserved.
//

#import "TXMainListTableViewCellText.h"

@implementation TXMainListTableViewCellText

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setText:(NSString *)text
{
    self.label.text = text;
}
@end
