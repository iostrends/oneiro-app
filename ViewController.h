//
//  ViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-01-28.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertBox.h"
#import "newJournalViewController.h"
#import "journalOptionsViewController.h"
#import "JournalController.h"
#import "newJEntryViewController.h"
#import "TableViewEntryBrowserTableViewController.h"
#import "UINotificationBanner.h"
#import "Randoms.h"


@class newJEntryViewController;
@class addNewDreamChar;
@class newJournalViewController;

@interface ViewController : UIViewController <NewJournalCreatedDelegate, JournalOptionsDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cmdBrowse;
@property (weak, nonatomic) IBOutlet UIButton *cmdNewJournalEntry;
@property (weak, nonatomic) IBOutlet UIButton *cmdCreateNewJournal;
@property (weak, nonatomic) IBOutlet UIButton *cmdJournalOptions;
@property (weak, nonatomic) IBOutlet UIButton *cmdTest;

// These keep track of the current journal properties that can get passed to another view
@property NSString *currentJournalTitle;
@property NSString *OwnerName;
@property NSString *CreateDate;
@end
