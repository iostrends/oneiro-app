//
//  journalOptionsViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-16.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamJournal.h"
#import "AlertBox.h"
#import "JournalController.h"
#import "UINotificationBanner.h"
@protocol JournalOptionsDelegate <NSObject>
- (void) didDeleteJournal;
@end
@interface journalOptionsViewController : UIViewController
{
    UIGestureRecognizer *tapRecognizer;
}

@property (weak, nonatomic) IBOutlet UIButton *cmdCancel;
@property (weak, nonatomic) IBOutlet UITextField *txtJournalTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCreateDate;
@property (weak, nonatomic) IBOutlet UILabel *lblOwnerName;
@property (weak, nonatomic) IBOutlet UIButton *cmdDeleteJournal;
@property (weak, nonatomic) IBOutlet UIButton *cmdRenameJournal;

@property (weak, nonatomic) NSString *refKey;
@property (weak, nonatomic) NSString *Options_CreateDate;
@property (weak, nonatomic) NSString *Options_JOwner;
@property (weak, nonatomic) NSString *Options_JTitle;

@property (weak, nonatomic) id <JournalOptionsDelegate> delegate;

@end
