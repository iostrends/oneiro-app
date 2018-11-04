//
//  journalOptionsViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-16.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "journalOptionsViewController.h"

#define defaultJournalKey @"journal"
@interface journalOptionsViewController ()

@end

@implementation journalOptionsViewController
@synthesize Options_JOwner, Options_JTitle, Options_CreateDate, refKey; // Properties passed forward

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void) keyboardWillShow: (NSNotification *) note
{
    [self.view addGestureRecognizer: tapRecognizer];
    
}
- (void) keyboardWillHide: (NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}
- (void) didTapAnywhere: (UITapGestureRecognizer *) recognizer
{
    // Dismiss the keyboard
    [_txtJournalTitle resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cmdCancel_Tap:(id)sender {
    
    // Cancel and dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    // Load the dream journal title.
    DreamJournal *Dj = [JournalController getArchievedDreamJournal:self.refKey];
    if (Dj != nil)
    {
        [_txtJournalTitle setText: Dj.Title];
    }
    
    _lblOwnerName.text = [_lblOwnerName.text stringByAppendingString:self.Options_JOwner];
    _lblCreateDate.text = [_lblCreateDate.text stringByAppendingString:self.Options_CreateDate];
}
- (IBAction)cmdDeleteJournal_Tap:(id)sender
{
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        NSLog(@"Dream Journal has been deleted (test)");
        [UINotificationBanner showBannerWithMessage:@"Journal deleted" forDuration:3.0];
        [JournalController deleteJournalArchieve:defaultJournalKey];
        [self.delegate didDeleteJournal]; // Call Delegate Function
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle: @"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Do nothing
    }];
    NSArray *alertActionsArray = [NSArray arrayWithObjects:okAction, cancelAction, nil];
    AlertBox *_alertDialog = [[AlertBox alloc] initWithTitleStringAndActionButtons:@"Delete Journal" :@"Are you sure you want to delete this journal. Action cannot be undone" :alertActionsArray];
    [self presentViewController:_alertDialog.internalController animated:YES completion:nil];
    
}
- (IBAction)cmdRenameJournal_Tap:(id)sender {
    
    // Prompt user to enter a new name with a InputUserBox
    
    UIAlertController *alertbox = [UIAlertController alertControllerWithTitle:@"Change Journal Title" message:@"Enter a new title for your journal:" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertbox addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.textColor = [UIColor blackColor];
         textField.clearButtonMode = UITextFieldViewModeWhileEditing;
         textField.borderStyle = UITextBorderStyleNone;
     }];
    
    [alertbox addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Action - this will change the name of the journal title
        
        if (![alertbox.textFields[0].text isEqualToString:@""])
        {
            DreamJournal *j = [JournalController getArchievedDreamJournal:self.refKey];
            // Load the journal
            j.Title = alertbox.textFields[0].text; // Update the title
            [self.txtJournalTitle setText:alertbox.textFields[0].text]; // Update the caption immediately
            // Save the data
            [JournalController saveArchieveDreamJournal:j forWhatKey:self.refKey];
            NSLog(@"User inputted: %@", alertbox.textFields[0].text);
            NSString *note_string = @"Journal renamed to ";
            NSString *final = [note_string stringByAppendingString:j.Title];
            [UINotificationBanner showBannerWithMessage:final forDuration:3];
        }
        
    }]];
    [alertbox addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //This will cancel out
        NSLog(@"User tapped cancel");
    }]];
    [self presentViewController:alertbox animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
