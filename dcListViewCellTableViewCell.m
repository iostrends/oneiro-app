//
//  dcListViewCellTableViewCell.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-04.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "dcListViewCellTableViewCell.h"

@implementation dcListViewCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnAdd_Tap:(id)sender {
    // Find the UITableViewCellIndexPath for the button tapped
    UIButton *thisButton = [[UIButton alloc] init];
    thisButton = (UIButton *) sender; //Cast
    long lng = (long)[thisButton tag];
    NSLog(@"Tapped %lu", lng);
    
    // When the user clicks add, we need to add the dream character to the current list of DCs in this journal entry
    // First we want to ensure the dream character we add isn't already in the list
}

@end
@implementation dcEntryListView
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
