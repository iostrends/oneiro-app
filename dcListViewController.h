//
//  dcListViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-03.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addNewDreamChar.h"
#import "DreamJournalEntry.h"
#import "newJEntryViewController.h"
#import "JournalController.h"
#import "UINotificationBanner.h"
@class addNewDreamChar;
@class newJEntryViewController;
@protocol DreamCharacterAddProtocol;
@protocol GetNewJournalEntryUpdates <NSObject>
- (void) JournalEntryCharacterAndEntryUpdates : (JournalEditBundle *) referenceBundle;
@end

@interface dcListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, DreamCharacterAddProtocol>
@property (strong, nonatomic) IBOutlet UITableView *dcTable;
@property NSMutableArray* dcList; // This is all of the DCs in the entire journal
@property NSMutableArray* dcListForJournalEntry; // This keeps
@property (strong, nonatomic) IBOutlet UITableView *tbl_ListOfdcInEntry;
@property (strong, nonatomic) IBOutlet UIButton *btnAddDC;
@property (strong, nonatomic) JournalEditBundle *eBundle;
@property (weak, nonatomic) id <GetNewJournalEntryUpdates> delegate;

@end
