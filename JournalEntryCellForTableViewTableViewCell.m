//
//  JournalEntryCellForTableViewTableViewCell.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "JournalEntryCellForTableViewTableViewCell.h"

@implementation JournalEntryCellForTableViewTableViewCell
@synthesize lblEntryTitle = _lblEntryTitle;
@synthesize lblEntryDate = _lblEntryDate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
