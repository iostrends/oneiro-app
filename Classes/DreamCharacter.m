//
//  DreamCharacter.m
//  Oneiro
//
//  Created by David Eastmond on 2017-10-04.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import "DreamCharacter.h"
#define defaultJournalKey @"journal"
//
@implementation DreamCharacter

@synthesize Name = _Name;
@synthesize CreateDate = _CreateDate;
@synthesize gender = _gender;
@synthesize description = _description;
@synthesize charID = _charID;


- (id) initWithNameAndGender:(NSString *)dcName :(DreamCharacterGender)dcGender
{
    // Assign the name and gender
    _Name = dcName;
    _gender = dcGender;
    _CreateDate = [NSDate date];
    _description = @"Default description";
    _charID = [self createUniqueDreamCharacterID];
    return self;
}
- (id) initWithNameGenderAndDescription: (NSString *) dcName gender: (DreamCharacterGender) dcGender description: (NSString *) dcDesc
{
    // Assign name, gender and description
    _Name = dcName;
    _gender = dcGender;
    _CreateDate = [NSDate date];
    _description = dcDesc;
    _charID = [self createUniqueDreamCharacterID];
    return self;
}
- (NSString *) createUniqueDreamCharacterID
{
    // We want to create a unique dream character ID
    
    // First we need a compare list of all the dream characters in the journal
    NSArray *compareList = [JournalController getAllDreamCharacters:defaultJournalKey];
    NSString *testID = @"";
    
    // If compare list is nil
    if (compareList == nil)
    {
        testID = [Randoms randomStringOfLength:8];
        return testID;
    }
    bool fndMatch = false;
    do
    {
        // Create a unique ID, then check it against compare list
        testID = [Randoms randomStringOfLength:8]; // Get an ID 8 characters long
        for (int i = 0; i <= compareList.count -1; i++)
        {
            if ([testID isEqualToString:compareList[i]])
            {
                fndMatch = true;
                break;
            }
        }
        if (fndMatch == false) {
            // We see no duplicates assign
            break;
        } else {
            fndMatch = false;
            testID = @"";
        }
    } while (true);
    NSLog(@"New CharID %@", testID);
    return testID;
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.Name = [aDecoder decodeObjectForKey:@"name"];
    _CreateDate = [aDecoder decodeObjectForKey:@"createDate"];
    self.gender = [aDecoder decodeIntForKey:@"gender"];
    _description = [aDecoder decodeObjectForKey:@"description"];
    _charID = [aDecoder decodeObjectForKey:@"charid"];
    
    return self;
}
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Name forKey:@"name"];
    [aCoder encodeObject:self.CreateDate forKey:@"createDate"];
    [aCoder encodeInt:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.charID forKey:@"charid"];
}
@end
