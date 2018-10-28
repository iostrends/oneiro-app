//
//  JournalEntryCellForTableViewTableViewCell.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalEntryCellForTableViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblEntryDate;
@property (strong, nonatomic) IBOutlet UILabel *lblEntryTitle;

@end
