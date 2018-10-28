//
//  newJEntryViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "newJEntryViewController.h"

@interface newJEntryViewController ()

@end

@implementation newJEntryViewController
@synthesize jKey;
@synthesize mode;
@synthesize edit_bundle;
@synthesize journalUpdateDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _cmdSaveAdd.layer.borderColor =  UIColor.blackColor.CGColor;
    _cmdSaveAdd.layer.borderWidth = 2;
    _cmdSaveAdd.layer.cornerRadius = 2;
    
    // Tap recognizers
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void) keyboardWillShow: (NSNotification *) note
{
    [self.view addGestureRecognizer:tapRecognizer];
}
- (void) keyboardWillHide: (NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}
- (void) didTapAnywhere: (UITapGestureRecognizer *) recognizer
{
    [_txtEntryText resignFirstResponder];
    [_txtEntryTitle resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cmdSaveAdd_Tap:(id)sender {
    
    // We either add a new journal entry, or we'll be editing an existing, depending on the mode
    /*
    if ([_txtEntryTitle.text isEqualToString:@""])
    {
        AlertBox *errorAlert = [[AlertBox alloc] initWithDefaultErrorMessage:@"Please enter a journal entry title"];
        [self presentViewController:errorAlert.internalController animated:YES completion:nil];
        return;
    } */
    if (self.mode == AddMode)
    {
        // Create a new journal entry, validate the input and call the
        //delegate method
        // Add Mode
        // Create the journal object
        
        if (edit_bundle.JournalEntryReference != nil)
        {
            NSLog(@"Journal was NOT nil. Processing delegate function");
            self.edit_bundle.JournalEntryReference.JournalEntryText = _txtEntryText.text;
            self.edit_bundle.JournalEntryReference.Title = _txtEntryTitle.text;
            [_delegate newJournalEntryCreated: self.edit_bundle.JournalEntryReference]; // Call the delegate
        } else {
            
            // Create a new reference
            DreamJournalEntry *ReferenceEntry = [[DreamJournalEntry alloc] initWithJournalEntryTitle:_txtEntryText.text];
            ReferenceEntry.JournalEntryText = _txtEntryText.text;
            ReferenceEntry.Title = _txtEntryTitle.text;
            self.edit_bundle = [[JournalEditBundle alloc] initWithJournalEntry:ReferenceEntry forIndex:-1];
            
            
            NSLog(@"Initialized a new Journal Entry Bundle");
            [_delegate newJournalEntryCreated:edit_bundle.JournalEntryReference]; // Call the delegate
        }
    } else {
        // We're in Update mode - updating an existing journal entry
        self.edit_bundle.JournalEntryReference.Title = _txtEntryTitle.text; // Get the title from the text box
        self.edit_bundle.JournalEntryReference.JournalEntryText = _txtEntryText.text; // Updated text
        [journalUpdateDelegate JournalEntryWasUpdatedEdited:self.edit_bundle];
    }
}
- (void) viewWillAppear:(BOOL)animated
{
    if (self.mode == AddMode)
    {
        // Update the button's caption
        [_cmdSaveAdd setTitle:@"Save/Add" forState:UIControlStateNormal];
    } else {
        [_cmdSaveAdd setTitle:@"Update" forState:UIControlStateNormal];
        
        // Populate
        //NSLog(self.edit_bundle.JournalEntryReference.JournalEntryText);
        [_txtEntryText setText:self.edit_bundle.JournalEntryReference.JournalEntryText];
        // _txtEntryText.text = edit_bundle.JournalEntryReference.JournalEntryText;
        
        [_txtEntryTitle setText:edit_bundle.JournalEntryReference.Title];
        //_txtEntryTitle.text = edit_bundle.JournalEntryReference.Title;
    }
}
- (void)JournalEntryCharacterAndEntryUpdates:(JournalEditBundle *)referenceBundle {
    // Update the edit bundle
    NSLog(@"Received journal Entry Important updates");
    
    self.edit_bundle = referenceBundle;
}
//MARK: Delegate Function
- (void) returnedDreamSigns : (NSMutableArray *) signs
{
    // Delegate method
    NSLog(@"NewJournalEntry - Dream Sign delegate received");
    [self.navigationController popViewControllerAnimated:YES];
    [_saveReminderLabel setHidden:NO]; // Show the save reminder
    [self.edit_bundle.JournalEntryReference AddDreamSignByMutableArray:signs];
    
}
/*
#pragma mark - Navigation
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // We need to
    if ([segue.identifier isEqualToString:@"toDCListVC"])
    {
        // This is the segue that will open up the DreamCharacter list
        dcListViewController* nextDCCtrl = [[dcListViewController alloc] init];
        nextDCCtrl = (dcListViewController *) segue.destinationViewController; // Cast
        nextDCCtrl.dcListForJournalEntry = self.edit_bundle.JournalEntryReference.dreamCharacters; // Send
        
        if (self.edit_bundle == nil) {
            // Edit Bundle needs to be instantiated
            // Create a new journal Entry Reference
            NSLog(@"Edit_bundle was nil. Instantiating...");
            DreamJournalEntry *tEntry = [[DreamJournalEntry alloc] initWithJournalEntryTitle:_txtEntryTitle.text];
            tEntry.JournalEntryText = _txtEntryText.text;
            tEntry.Title = _txtEntryTitle.text;
            
            self.edit_bundle = [[JournalEditBundle alloc] initWithJournalEntry:tEntry forIndex:-1];
            
        }
        nextDCCtrl.eBundle = self.edit_bundle; // Set the edit bundle
        nextDCCtrl.delegate = self;
    } else if ([segue.identifier isEqualToString:@"segue_dsEdit"])
    {
        // Create an edit bundle reference
        if (self.edit_bundle == nil)
        {
            DreamJournalEntry *tEntry = [[DreamJournalEntry alloc] initWithJournalEntryTitle:_txtEntryTitle.text];
            tEntry.JournalEntryText = _txtEntryText.text;
            tEntry.Title = _txtEntryTitle.text;
            self.edit_bundle = [[JournalEditBundle alloc] initWithJournalEntry:tEntry forIndex:-1];
            NSLog(@"Preparing to show dream signs. Edit bundle is nil, so created reference");
        }
        // Dream sign screen, which shows the current dream signs and allows users to add or delete
        dsViewController *controller = [[dsViewController alloc] init];
        controller = (dsViewController *) segue.destinationViewController;
        controller.dsListForJournalEntry = edit_bundle.JournalEntryReference.dreamSigns;
    }
}
@end
