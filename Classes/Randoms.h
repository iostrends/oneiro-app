//
//  Randoms.h
//  Oneiro
//
//  Created by David Eastmond on 2018-03-05.
//  Copyright © 2018 David Eastmond. All rights reserved.
//
/*
 This holds utilities to generate random numbers or random string of characters
 */

#import <Foundation/Foundation.h>

@interface Randoms : NSObject
    + (int) randomIntegerBetween : (int) min and: (int) max;
    + (NSString *) randomStringOfLength : (NSUInteger) len;
@end
