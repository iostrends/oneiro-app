//
//  Randoms.m
//  Oneiro
//
//  Created by David Eastmond on 2018-03-05.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "Randoms.h"

@implementation Randoms

// Generate a random value
+ (int) randomIntegerBetween:(int)min and:(int)max
{
    return (int) (min + arc4random_uniform(max - min + 1));
}
+ (NSString *) randomStringOfLength:(NSUInteger)len
{
    NSUInteger maxlen = len;
    if (len <= 0)
    {
        // Instead of throwing an exception, set the default length to three chars
        maxlen = 3;
    }
    
    NSMutableString *ReturnString = [[NSMutableString alloc] initWithString:@""];
    
    for (int i = 1; i <= maxlen; i++)
    {
        // Characters (including numerals)
        int alphaValue = [self randomIntegerBetween:65 and:90];
        int numValue = [self randomIntegerBetween:48 and:57];
        NSInteger numOrLetter = [self randomIntegerBetween:0 and:2];
        
        NSString *charChoice;
        if(numOrLetter == 0)
        {
            // Make a letter
            charChoice = [NSString stringWithFormat:@"%c", alphaValue];
        } else {
            charChoice = [NSString stringWithFormat:@"%c", numValue];
        }
        [ReturnString appendString:charChoice];
    }
    return ReturnString;
}
@end
