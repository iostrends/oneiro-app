//
//  dsViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-25.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "dsViewController.h"

@interface dsViewController ()

@end

@implementation dsViewController
@synthesize dsListForJournalEntry;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dsTableView.delegate = self; // Set delegate
    _dsTableView.dataSource = self;
    if (dsListForJournalEntry == nil)
    {
        // Init the array
        NSLog(@"The dream sign array is nil");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Load the data, get the cell
    static NSString *cellID = @"cell";
    // Create cell instance
    dsCellTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // Instantiate the cell should it be nil
    if (cell == nil)
    {
        cell = [[dsCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // Set the label text
    cell.dsLabel.text = [dsListForJournalEntry objectAtIndex:[indexPath row]];
    return cell;
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dsListForJournalEntry.count;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Segue prep - mainly for the custom addDreamSign
    
    if ([segue.identifier isEqualToString:@"showAddDSPop"])
    {
        // Call delegate
        addDreamSignPopUpVC *addCustomSignsViewController = [[addDreamSignPopUpVC alloc] init];
        addCustomSignsViewController = (addDreamSignPopUpVC *) segue.destinationViewController;
        addCustomSignsViewController.delegate = self;
        // prepare any other properties ...
    }
}

- (void)addDreamSignsToJournalEntry:(NSMutableArray<NSString *> *)dreamSignsAdded {
    // Get the array.
    //[self.navigationController popViewControllerAnimated:YES]; // Dismiss
    NSLog(@"got the dream sign delegate signal");
    
    // Let's combine contents of the array and then eliminate any duplicates
    [dsListForJournalEntry addObjectsFromArray:dreamSignsAdded];
    
    // Clean up
    
    NSArray *cleanArray = [[NSSet setWithArray: dsListForJournalEntry] allObjects];
    dsListForJournalEntry = [NSMutableArray arrayWithArray:cleanArray]; // Update and replace
     
    [_dsTableView reloadData];
}
- (IBAction)clickSaveDS:(id)sender {
    // Need to call a delegate
    [_delegate returnedDreamSigns:dsListForJournalEntry]; // Call delegate
}
@end
