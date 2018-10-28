//
//  UINotificationBanner.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-24.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINotificationBanner : UIView
+ (void) showBannerWithMessage : (NSString *)aMessage forDuration: (CGFloat)aDuration;
@end
