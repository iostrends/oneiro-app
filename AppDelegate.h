//
//  AppDelegate.h
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

