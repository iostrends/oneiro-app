//
//  newJournalViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-13.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "newJournalViewController.h"
#define defaultJournalKey @"journal"
@implementation newJournalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    _txtJournalTitle.delegate = self;
    _txtFN.delegate = self;
    _txtLN.delegate = self;
     */
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_txtLN resignFirstResponder];
    [_txtFN resignFirstResponder];
}

// Mark: Functions
- (IBAction)cmdCancel_Click:(id)sender {
    // User clicked cancel: we'll call the delegate function
    [_delegate didCreateNewJournal:false]; // Set to false
}
- (IBAction)cmdCreateJournal_Click:(id)sender {
    
    // We try to create the basic journal file and then pass back
    // a success indicator to the delegate function
    // DreamJournal *newJournal = [[DreamJournal alloc] init]
    //[_delegate didCreateNewJournal:true];
    
    // Let's get a date of birth
    NSDate *dob = [[NSDate alloc] init];
    dob = [_datePicker date];
    
    // Journal owner
    JournalOwner *owner = [[JournalOwner alloc] initWithOwnerFirstAndLastName:[_txtFN text] withLastName: [_txtLN text] withDateOfBirth:dob];
    
    // Main journal
    DreamJournal *journal = [[DreamJournal alloc] initWithTitleOwnerAndDefaultEntry:[_txtJournalTitle text] :owner];
    
    // Create a key in NSUserDefaults
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:journal];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:defaultJournalKey];
    
    // Supply delegate function
    [_delegate didCreateNewJournal:journal]; // Pass journal back
    
}
- (IBAction)datePicker_ValueChanged:(id)sender {
    
}
- (IBAction)cmdCreateJournal_Tap:(id)sender {
    
    // Creating a journal data file
    
    // First we validate the user input
    if ([_txtFN.text isEqualToString:@""] || [_txtLN.text isEqualToString: @""] || [_txtJournalTitle.text isEqualToString:@""])
    {
        UIAlertAction *ActionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            // Do nothing
            
        }];
        
        NSArray *actions = [NSArray arrayWithObjects:ActionOK, nil];
        AlertBox *InvalidInputAlertBox = [[AlertBox alloc] initWithTitleStringAndActionButtons:@"Incomplete Fields" :@"Please Enter all fields" :actions];
        
        // Show the error message indication that fields were not complete.
        [self presentViewController:InvalidInputAlertBox.internalController animated:YES completion:nil];
        
        return;
    }
    // Passed the validation
    // Create a journalOwner Object
    JournalOwner *tOwner = [[JournalOwner alloc] initWithOwnerFirstAndLastName:_txtFN.text withLastName:_txtLN.text withDateOfBirth:_datePicker.date];
    
    DreamJournal *newJournal = [[DreamJournal alloc] initWithTitleOwnerAndDefaultEntry:_txtJournalTitle.text :tOwner];
    
    // Write the journal to file
    [JournalController saveArchieveDreamJournal:newJournal
                                     forWhatKey:defaultJournalKey];
    // Return using delegate
    [_delegate didCreateNewJournal:newJournal];
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
