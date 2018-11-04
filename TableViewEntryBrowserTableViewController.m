//
//  TableViewEntryBrowserTableViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-19.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "TableViewEntryBrowserTableViewController.h"
#import "JournalEntryCellForTableViewTableViewCell.h"
#define defaultJournalKey @"journal"

@interface TableViewEntryBrowserTableViewController ()

@end

@implementation TableViewEntryBrowserTableViewController
@synthesize pJournalEntries = _pJournalEntries;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _tableViewTitle.title = [JournalController getJournalTitle:defaultJournalKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _pJournalEntries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // This is the cell reuse ID
    static NSString *cellID = @"jeCell";
    JournalEntryCellForTableViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil)
    {
        // Instantiate a new cell
        cell = [[JournalEntryCellForTableViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    // Get the date in proper format
    NSDateFormatter *tFormatter = [[NSDateFormatter alloc] init];
    DreamJournalEntry *_entry = (DreamJournalEntry *)[_pJournalEntries objectAtIndex:[indexPath row]];
    cell.lblEntryTitle.text = _entry.Title;
    [tFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    cell.lblEntryDate.text = [tFormatter stringFromDate:_entry.CreateDate];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"You tapped index %lu", [indexPath row]);
    // Create a JournalEditBundle object that contains the journalEntry[x] and x as index path row
    JournalEditBundle *referencePass = [[JournalEditBundle alloc] initWithJournalEntry:[_pJournalEntries objectAtIndex:[indexPath row]] forIndex:[indexPath row]];
    
    [self performSegueWithIdentifier:@"segueEditEntry" sender:referencePass];
}
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Allow delete
    return UITableViewCellEditingStyleDelete;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [_pJournalEntries removeObjectAtIndex:[indexPath row]];
       
        [UINotificationBanner showBannerWithMessage:@"Entry deleted." forDuration:2];
        [JournalController saveJournalEntryForEntryArray:_pJournalEntries forJournalEntryKey:defaultJournalKey];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"segueEditEntry"])
    {
        // Cast the sender
        JournalEditBundle *Bundle = [[JournalEditBundle alloc] init];
        Bundle = (JournalEditBundle *) sender; // Cast
        
        // Segue edit mode
        NSLog(@"Edit Mode: %@", Bundle.JournalEntryReference.Title);
        newJEntryViewController *editEntryController = [[newJEntryViewController alloc] init];
        editEntryController = (newJEntryViewController *) segue.destinationViewController; // Cast
        editEntryController.journalUpdateDelegate = self; // set delegate
        editEntryController.edit_bundle = Bundle;
        editEntryController.mode = EditMode; // Set in edit mode
    } else if ([segue.identifier isEqualToString:@"segueEditEntry01"])
    {
        // Cast the sender
        DreamJournalEntry *refEntry = [[DreamJournalEntry alloc] initWithJournalEntryTitle:@""];
        JournalEditBundle *Bundle = [[JournalEditBundle alloc] initWithJournalEntry:refEntry forIndex:-1];
        //Bundle = (JournalEditBundle *) sender; // Cast
        
        // Segue edit mode
        NSLog(@"Add Mode: %@", Bundle.JournalEntryReference.Title);
        newJEntryViewController *editEntryController = [[newJEntryViewController alloc] init];
        editEntryController = (newJEntryViewController *) segue.destinationViewController; // Cast
        editEntryController.delegate = self; // set delegate
        editEntryController.edit_bundle = Bundle;
        editEntryController.mode = AddMode; // Set in edit mode
    }
}
- (void) JournalEntryWasUpdatedEdited:(JournalEditBundle *)editEntry
{
    [self.navigationController popViewControllerAnimated:YES];
    // Delegate method - get the Bundle, which contains the refreshed journal with any edits and the index number
    NSLog(@"Got the call back for updated journal entry");
    NSLog(@"Edit %@", editEntry.JournalEntryReference.JournalEntryText);
    
    DreamJournal *tempJournal = [JournalController getArchievedDreamJournal:defaultJournalKey];
    [tempJournal.journalEntries replaceObjectAtIndex:editEntry.EntryIndex withObject:editEntry.JournalEntryReference];
    [JournalController saveArchieveDreamJournal:tempJournal forWhatKey:defaultJournalKey]; // Save
    [UINotificationBanner showBannerWithMessage:@"Entry was updated." forDuration:3];
    _pJournalEntries = tempJournal.journalEntries; // TEST
    [self.tableView reloadData];
    // Test
    
}
- (void) newJournalEntryCreated:(DreamJournalEntry *)createdEntry
{
    [self.navigationController popViewControllerAnimated:YES]; // Dismiss
    // We need to save and add
    [JournalController addJournalEntryToJournal:createdEntry forWhatKey:defaultJournalKey];
    [self.tableView reloadData]; // Refresh
    NSLog(@"New Entry was added");
}
@end
