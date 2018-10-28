//
//  addDreamSignPopUpVC.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-28.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "ViewController.h"
#import "JournalController.h"
#import "dsCellTableViewCell.h"

@protocol dreamSignCustomDelegateProtocol <NSObject>
- (void) addDreamSignsToJournalEntry : (NSMutableArray <NSString *> *) dreamSignsAdded;
@end
@interface addDreamSignPopUpVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSInteger selectedRow;
    NSMutableArray *selectedIndex;
    UITapGestureRecognizer *tapRecognizer;
    BOOL addUpdate;
}
@property (strong, nonatomic) IBOutlet UITableView *customDSTableView;
@property (strong, nonatomic) IBOutlet UITextField *txtAddCustomDS;
@property NSMutableArray <NSString *>* defaultDreamSignArray;
@property (weak, nonatomic) id <dreamSignCustomDelegateProtocol> delegate;
@end
