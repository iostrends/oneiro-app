//
//  dcListViewController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-03.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "dcListViewController.h"
#import "dcListViewCellTableViewCell.h"
#define defaultJournalKey @"journal"
@interface dcListViewController ()

@end

@implementation dcListViewController
@synthesize dcList = _dcList; // Dream character list
@synthesize eBundle = _eBundle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dcTable.tag = 1;
    _tbl_ListOfdcInEntry.tag = 2;
    
    // Load the data array
    _dcTable.dataSource = self;
    _dcTable.delegate = self;
    
    _dcList = [JournalController getAllDreamCharacters:defaultJournalKey];
    
   _tbl_ListOfdcInEntry.dataSource = self;
   _tbl_ListOfdcInEntry.delegate = self;
    
    // We need to populate the data of the current characters in this particular journalEntry
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"add_dc00"])
    {
        // Launch the AddDreamCharacter screen
        addNewDreamChar *addnew = [[addNewDreamChar alloc] init];
        addnew = (addNewDreamChar *) segue.destinationViewController;
        addnew.delegate = self;
    }
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (tableView.tag == 1)
    {
        static NSString *cellID = @"dcCell";
        dcListViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
        if (cell == nil)
        {
            cell = [[dcListViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        DreamCharacter *dc = [_dcList objectAtIndex:[indexPath row]];
        cell.lblDcName.text = dc.Name;
        
        // Change the AddButton Border color and thickness
        cell.btnAdd.layer.cornerRadius = 1;
        cell.btnAdd.layer.borderWidth = 0.5;
        cell.btnAdd.layer.borderColor = UIColor.blueColor.CGColor;
        cell.btnAdd.tag = [indexPath row];
        if (dc.description == nil)
        {
            cell.lblDcDesc.text = @"default nil description";
        } else{
            
            cell.lblDcDesc.text = dc.description;
        }
        
        if ([dc.Name isEqualToString:@"default dream character"])
        {
            [cell.btnAdd setEnabled:NO];
            
        }
        return cell;
    } else
    {
        // This is the dcEntryList
        static NSString *cellID = @"dcCell2";
        
        dcEntryListView *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[dcEntryListView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        DreamCharacter *indexChar = _eBundle.JournalEntryReference.dreamCharacters[indexPath.row];
        cell.dcEntry_Name.text = indexChar.Name;
        cell.dcEntry_Desc.text = indexChar.description;
                                                   
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 1)
    {
        return _dcList.count;
    } else {
        return _eBundle.JournalEntryReference.dreamCharacters.count;
    }
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1)
    {
        return 65;
    } else {
        return 40;
    }
    //return [indexPath row] * 75;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2)
    {
        return YES;
    } else {
        return NO;
    }
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Allow delete
    if (tableView.tag == 2)
    {
        return UITableViewCellEditingStyleDelete;
        
    } else {
        return UITableViewCellEditingStyleNone;
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2)
    {
        if (editingStyle == UITableViewCellEditingStyleDelete)
        {
            // Delete the specific dreamCharacter in the jEntry[indexPath row] and refresh
            [_eBundle.JournalEntryReference.dreamCharacters removeObjectAtIndex:[indexPath row]]; // Delete
            
            [tableView reloadData];
            [UINotificationBanner showBannerWithMessage:@"DC Deleted" forDuration:3];
            
            // Save the changes immediately
            [JournalController saveJournalEntryForEntryIndex:_eBundle.EntryIndex forEntry:_eBundle.JournalEntryReference Key:defaultJournalKey];
            
            // ** test
            _dcList = [JournalController getAllDreamCharacters:defaultJournalKey];
            [_dcTable reloadData];
        }
    }
}
- (void)DreamCharacterAdded:(DreamCharacter *)characterAdded {
    //
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"Got the DC to add %@", characterAdded.Name);
    [_eBundle.JournalEntryReference.dreamCharacters addObject:characterAdded];
    [_tbl_ListOfdcInEntry reloadData];
    [UINotificationBanner showBannerWithMessage: @"Dream Character was added." forDuration: 3];
    [_delegate JournalEntryCharacterAndEntryUpdates:_eBundle];
    // We need to pass the updated JournalEntryReference back out via a delegate
}
@end
