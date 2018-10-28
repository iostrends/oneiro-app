//
//  dcListViewCellTableViewCell.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-04.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINotificationBanner.h"
@class dcEntryListView;

@interface dcListViewCellTableViewCell : UITableViewCell
    @property (strong, nonatomic) IBOutlet UILabel *lblDcName;
    @property (strong, nonatomic) IBOutlet UILabel *lblDcDesc;
    @property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@end

@interface dcEntryListView : UITableViewCell
    @property (strong, nonatomic) IBOutlet UILabel *dcEntry_Name;
    @property (strong, nonatomic) IBOutlet UILabel *dcEntry_Desc;
@end
