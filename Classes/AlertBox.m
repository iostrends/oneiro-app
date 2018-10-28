//
//  AlertBox.m
//  Oneiro
//
//  Created by David Eastmond on 2018-01-29.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "AlertBox.h"

@implementation AlertBox
@synthesize internalController;
- (id) initWithTitleStringAndActionButtons:(NSString *)AlertBoxTitle :(NSString *)AlertBoxTextBody :(NSArray *) ActionList
{
    // Constructor
    internalController = [UIAlertController alertControllerWithTitle:AlertBoxTitle
                                                              message:AlertBoxTextBody preferredStyle:UIAlertControllerStyleAlert];
    
    // We need to add the actions
    [self loadActions:ActionList];
    // [controller presentViewController:internalController animated:true completion:nil];
    return self;
}
- (void) loadActions: (NSArray *) actionsToLoad
{
    // This loads up the actions and adds them to UIAlertController property
    for (id obj in actionsToLoad)
    {
        if ([obj isKindOfClass:[UIAlertAction class]])
        {
            [internalController addAction:obj]; // Add the action to the list of actions
            
        } else {
            NSLog(@"Warning, one of the items in the action list is of an invalid type.");
        }
    }
    
}

- (id) initWithDefaultErrorMessage:(NSString *)defaultErrorMessageText
{
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"No action");
    }];
    internalController = [UIAlertController alertControllerWithTitle:@"Error" message:defaultErrorMessageText preferredStyle:UIAlertControllerStyleAlert];
    [internalController addAction:actionOK];
    
    return self;
}
@end

@implementation UIInputBox

@end
