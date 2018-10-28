//
//  addDreamSignPopUpVC.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-28.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "addDreamSignPopUpVC.h"

@interface addDreamSignPopUpVC ()

@end

@implementation addDreamSignPopUpVC
@synthesize  defaultDreamSignArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _txtAddCustomDS.layer.borderColor = UIColor.blackColor.CGColor;
    _txtAddCustomDS.layer.borderWidth = 2;
    _txtAddCustomDS.layer.cornerRadius = 1;
    // set delegate and data source
    _customDSTableView.dataSource = self;
    _customDSTableView.delegate = self;
    
    // Load the default dreamsigns array
    defaultDreamSignArray = [JournalController loadDefaultDreamSignDatabase];
    selectedRow = -1;
    
    selectedIndex = [[NSMutableArray alloc] initWithArray: defaultDreamSignArray];
    // Populate
    for (int i = 0; i < defaultDreamSignArray.count; i++)
    {
        [selectedIndex setObject:@(NO) atIndexedSubscript:i];
        //NSLog(@"Object %d", i);
    }
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // TEST:
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    NSMutableArray *cellArray = [[NSMutableArray alloc] init];
    for (int j = 0; j <= [_customDSTableView numberOfRowsInSection:1]; j++ )
    {
        dsCellTableViewCell* tCell = [_customDSTableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow:j inSection:1]];
        [cellArray addObject:tCell];
    }
    NSLog(@"Cell array"); */
   
    return defaultDreamSignArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    dsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dsCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[dsCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dsCell"];
    }
    cell.dsDefault.text = defaultDreamSignArray[indexPath.row];
    // Problem code:
    //selectedIndex = [[NSMutableArray alloc] initWithArray:defaultDreamSignArray];
    if([selectedIndex[indexPath.row] integerValue] == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else if ([selectedIndex[indexPath.row] integerValue] == 1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        NSLog(@"Invalid value");
    }
    // END PROBLEM CODE
    cell.isCheckable = true;
    
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30; //
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    if ([selectedIndex[indexPath.row] integerValue] == 0)
    {
        [selectedIndex setObject:@(YES) atIndexedSubscript:indexPath.row];
       NSLog(@"Value was set to checked");
    } else {
        [selectedIndex setObject:@(NO) atIndexedSubscript:indexPath.row];
         NSLog(@"Value was set to UNchecked");
    }
    //[tableView reloadData];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
- (IBAction)customDSAdded:(id)sender {
    // Adds the custom dream sign to list
    if ([_txtAddCustomDS.text isEqualToString:@""])
    {
        // Nothing will be added
        AlertBox *alert = [[AlertBox alloc] initWithDefaultErrorMessage:@"Please supply a valid dream sign text"];
        
    } else
    {
        [defaultDreamSignArray addObject:_txtAddCustomDS.text];
        // Add
        NSLog(@"Added %@", _txtAddCustomDS.text);
        [_customDSTableView reloadData];
        _txtAddCustomDS.text = @"";
        [selectedIndex addObject:@(YES)]; // NEW CODE:
        addUpdate = true;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)dimissCustomDreamSignVC:(id)sender {
    
    // Get all the elements that need to be added
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < selectedIndex.count; i++)
    {
        if ([selectedIndex[i] integerValue]== 1)
        {
            // This is an element we want to take back
            [returnArray addObject:defaultDreamSignArray[i]];
            NSLog(@"Dream sign %@ has been added", defaultDreamSignArray[i]);
        }
    }
    // Call the delegate function
    [_delegate addDreamSignsToJournalEntry:returnArray]; //

    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_txtAddCustomDS resignFirstResponder];
  
}
@end
