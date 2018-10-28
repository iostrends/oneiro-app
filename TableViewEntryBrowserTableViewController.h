//
//  TableViewEntryBrowserTableViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "newJEntryViewController.h"
#import "DreamJournalEntry.h"
#import "JournalController.h"
#import "UINotificationBanner.h"
@protocol EditUpdateJournalEntryDelegate;
@protocol NewJournalEntryDelegate;
@interface TableViewEntryBrowserTableViewController : UITableViewController <EditUpdateJournalEntryDelegate, NewJournalEntryDelegate>
{
   
}
@property (strong, nonatomic) IBOutlet UINavigationItem *tableViewTitle;
@property NSMutableArray *pJournalEntries;
@end
