//
//  newJEntryViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamJournal.h"
#import "DreamCharacter.h"
#import "DreamJournalEntry.h"
#import "AlertBox.h"
#import "dcListViewController.h"
#import "dsViewController.h"
@class newJEntryViewController;
@class JournalEditBundle;
@protocol GetNewJournalEntryUpdates;
@protocol dreamSignsDelegateProtocol;

typedef enum {
    AddMode =1, EditMode =2
} JournalEntryMode;

// Delegate method that passes back the entry created
@protocol NewJournalEntryDelegate <NSObject>
- (void) newJournalEntryCreated : (DreamJournalEntry *)createdEntry;
@end
@protocol EditUpdateJournalEntryDelegate <NSObject>
- (void) JournalEntryWasUpdatedEdited : (JournalEditBundle *) editEntry;
@end
@interface newJEntryViewController : UIViewController <GetNewJournalEntryUpdates, dreamSignsDelegateProtocol>
{
    UITapGestureRecognizer *tapRecognizer;
}
@property (weak, nonatomic) IBOutlet UIButton *cmdSaveAdd;
@property (weak, nonatomic) IBOutlet UIButton *cmdCancel;

@property (weak, nonatomic) IBOutlet UITextField *txtEntryTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtEntryText;
@property (strong, nonatomic) IBOutlet UILabel *saveReminderLabel;

@property NSString *jKey;
@property (weak, nonatomic) id <NewJournalEntryDelegate> delegate;
@property (weak, nonatomic) id <EditUpdateJournalEntryDelegate> journalUpdateDelegate;
@property JournalEntryMode mode;

@property (strong, nonatomic) JournalEditBundle *edit_bundle;


@end

