//
//  dsCellTableViewCell.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-25.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "dsCellTableViewCell.h"

@implementation dsCellTableViewCell
@synthesize isChecked, isCheckable;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
