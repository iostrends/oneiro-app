//
//  addNewDreamChar.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-10.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "ViewController.h"
#import "DreamCharacter.h"
#import "UINotificationBanner.h"
#import "DreamJournal.h"

@protocol DreamCharacterAddProtocol <NSObject>
- (void) DreamCharacterAdded : (DreamCharacter *) characterAdded;
@end

@interface addNewDreamChar : UIViewController
    @property (strong, nonatomic) IBOutlet UISegmentedControl *btn_genderPicker;
    @property (strong, nonatomic) IBOutlet UITextField *txt_DCName;
    @property (strong, nonatomic) IBOutlet UITextView *txt_Dc_Desc;


    @property (weak, nonatomic) id <DreamCharacterAddProtocol> delegate;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtn_Save;
@end
