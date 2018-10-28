//
//  addNewDreamChar.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-10.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "addNewDreamChar.h"

@interface addNewDreamChar ()

@end

@implementation addNewDreamChar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)barBtnSave_Tap:(id)sender
{
    // Validation
    if ([_txt_DCName.text isEqualToString:@""]) {
        return ;
        
    }
    // Gender
    DreamCharacterGender g;
    if (_btn_genderPicker.selectedSegmentIndex == 0 )
    {
        g = female;
    } else if (_btn_genderPicker.selectedSegmentIndex == 1){
        g = male;
    } else {
        g = other;
    }
    
    DreamCharacter *dcToAdd = [[DreamCharacter alloc] initWithNameGenderAndDescription:_txt_DCName.text gender:g description:_txt_Dc_Desc.text];
    
    // Call delegate function to pass back the character
    [_delegate DreamCharacterAdded:dcToAdd];
}
#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue destinationViewController ])
}
*/

@end
