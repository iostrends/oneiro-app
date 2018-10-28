//
//  newJournalViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-13.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamJournal.h"
#import "AlertBox.h"
#import "JournalController.h"

@protocol NewJournalCreatedDelegate <NSObject>
- (void) didCreateNewJournal : (DreamJournal *) returnedJournal;
@end

@interface newJournalViewController : UIViewController <UITextViewDelegate>
{
    UITapGestureRecognizer *tapRecognizer;
}
@property (weak, nonatomic) IBOutlet UIButton *cmdCancel;
@property (weak, nonatomic) IBOutlet UIButton *cmdCreateJournal;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *txtFN;
@property (weak, nonatomic) IBOutlet UITextView *txtLN;
@property (weak, nonatomic) IBOutlet UITextView *txtJournalTitle;


// Delegate property
@property (weak, nonatomic) id <NewJournalCreatedDelegate> delegate;

@end
