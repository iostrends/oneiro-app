//
//  dsViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-25.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "ViewController.h"
#import "dsCellTableViewCell.h"
#import "addDreamSignPopUpVC.h"
@protocol dreamSignCustomDelegateProtocol;

@protocol dreamSignsDelegateProtocol <NSObject>
- (void) returnedDreamSigns : (NSMutableArray *) signs;
@end
@interface dsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, dreamSignCustomDelegateProtocol>
@property NSMutableArray *dsListForJournalEntry;
@property (strong, nonatomic) IBOutlet UITableView *dsTableView;
@property (weak, nonatomic) id <dreamSignsDelegateProtocol> delegate;
@end
