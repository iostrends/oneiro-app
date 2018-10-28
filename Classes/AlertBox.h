//
//  AlertBox.h
//  Oneiro
//
//  Created by David Eastmond on 2018-01-29.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <UIKit/UIKit.h>

@interface AlertBox : NSObject
{
    // Title and text
    NSString *AlertBoxTitle;
    NSString *AlertBoxText;
    NSArray *AlertBoxActions;
    
    
}
@property UIAlertController *internalController;
- (id) initWithTitleStringAndActionButtons : (NSString *) AlertBoxTitle
                                           : (NSString *) AlertBoxTextBody
                                           : (NSArray *) ActionList;
                                           

- (id) initWithDefaultErrorMessage : (NSString *) defaultErrorMessageText;
@end

@interface UIInputBox : UIAlertController


@end
