//
//  DreamJournalEntry.m
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import "DreamJournalEntry.h"

@implementation DreamJournalEntry

@synthesize JournalEntryText;
@synthesize dreamCharacters = _dreamCharacters;
@synthesize Title = _Title;
@synthesize CreateDate = _CreateDate;
@synthesize dreamSigns = _dreamSigns;

- (id) initWithJournalEntryTitle:(NSString *)entryTitle
{
    // Property assign the entry date
    _CreateDate = [NSDate date];
    _Title = entryTitle;
    _dreamCharacters = [[NSMutableArray alloc] init];
    _dreamSigns = [[NSMutableArray alloc] init]; // Initialize
    self.JournalEntryText = @"";
    // create a default dreamsign
    NSString *defaultSign = @"default";
    [self AddDreamSign:defaultSign]; // Add the dream sign to the mutable array
    
    // Create a default dream character
    DreamCharacter *defaultChar = [[DreamCharacter alloc] initWithNameAndGender:@"default dream character" :male];
    [self AddDreamCharacter:defaultChar];
    return self;
}

- (void) AddDreamCharacter:(DreamCharacter *)charToAdd
{
    // Adds a dream character
    [_dreamCharacters addObject:charToAdd];
    NSLog(@"Added object %@", charToAdd.Name);
}
- (void) AddDreamSign: (NSString *) dreamSignToAdd
{
    [_dreamSigns addObject:dreamSignToAdd];
}
- (bool) isIDInJournalEntry:(NSString *)charID
{
    // This method will check if DreamCharacter ID is in this entry array
    
    if ([charID isEqualToString: @""] || charID == nil)
    {
        // User cannot give an empty string as a parameter for the dreamCharacter ID
        NSException *e = [[NSException alloc] initWithName:@"InvalidArgumentException" reason:@"Character ID cannot be an empty string nor can it be nil" userInfo:nil];
        @throw e;
    }
    bool isFnd = NO; // our toggle, local variable
    for (int i = 0; i <= _dreamCharacters.count; i++)
    {
        if ([charID isEqualToString: [_dreamCharacters[i] charID]])
        {
            // If we've found a matching CharacterID
            isFnd = YES;
            break; // Exit out
        }
    }
    return isFnd;
}
- (void) AddDreamSignByArray:(NSArray *)arrayToAdd
{
    if (arrayToAdd != nil)
    {
        // This essentially replaces the dreamSign array
        _dreamSigns = [NSMutableArray arrayWithArray:arrayToAdd];
        NSLog(@"Updated dream sign array. It still needs to be saved.");
    } else {
        // Throw a null reference exception
        NSException *NullReferenceException = [[NSException alloc] initWithName:@"Null Reference Exception" reason:@"In the AddDreamSignByArray method in the dreamJournalEntry class, a nil argument was passed" userInfo:nil];
        
        @throw NullReferenceException;
    }
}
- (void) AddDreamSignByMutableArray:(NSMutableArray *)arrayToAdd
{
    if (arrayToAdd != nil)
    {
        // This essentially replaces the dreamSign array
        _dreamSigns = [NSMutableArray arrayWithArray:arrayToAdd];
        NSLog(@"Updated dream sign array. It still needs to be saved.");
    } else {
        // Throw a null reference exception
        NSException *NullReferenceException = [[NSException alloc] initWithName:@"Null Reference Exception" reason:@"In the AddDreamSignByArray method in the dreamJournalEntry class, a nil argument was passed" userInfo:nil];
        
        @throw NullReferenceException;
    }
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.JournalEntryText = [aDecoder decodeObjectForKey:@"entryText"];
    _dreamCharacters = [aDecoder decodeObjectForKey:@"dcs"];
    self.Title = [aDecoder decodeObjectForKey:@"title"];
    _CreateDate = [aDecoder decodeObjectForKey: @"createDate"];
    _dreamSigns = [aDecoder decodeObjectForKey:@"dreamsigns"];
    return self;
}
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.JournalEntryText forKey:@"entryText"];
    [aCoder encodeObject:self.dreamCharacters forKey:@"dcs"];
    [aCoder encodeObject:self.Title forKey:@"title"];
    [aCoder encodeObject:self.CreateDate forKey:@"createDate"];
    [aCoder encodeObject:self.dreamSigns forKey:@"dreamsigns"];
}
@end

@implementation JournalEditBundle

@synthesize JournalEntryReference = _reference;
@synthesize EntryIndex;
- (id) initWithJournalEntry:(DreamJournalEntry *)Entry forIndex:(NSInteger)index
{
    _reference = Entry;
    EntryIndex = index;
    return self;
}
@end
