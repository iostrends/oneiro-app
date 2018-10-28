//
//  dsCellTableViewCell.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-25.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dsCellTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dsLabel;
@property (strong, nonatomic) IBOutlet UILabel *dsDefault;
@property BOOL isChecked;
@property BOOL isCheckable;

@end
