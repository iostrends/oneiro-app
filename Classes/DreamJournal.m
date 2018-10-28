//
//  DreamJournal.m
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import "DreamJournal.h"


#define kObjectKey @"object"

@implementation DreamJournal
@synthesize journalEntries = _journalEntries;
@synthesize Title = _Title;


@synthesize Owner = _Owner;
@synthesize CreateDate = _CreateDate;
- (void) addEntryToJournal:(DreamJournalEntry *)entryToAdd
{
    if (entryToAdd != nil)
    {
        if ([entryToAdd isKindOfClass:[DreamJournalEntry class]])
        {
            [_journalEntries addObject:entryToAdd]; // Add to journal
        } else
        {
            // ** Exception
            NSException *invalidArgumentException = [NSException exceptionWithName:@"InvalidArgumentException" reason:@"Argument does not conform to type 'DreamJournalEntry'" userInfo:nil];
            @throw invalidArgumentException;
        }
    }
}
- (DreamJournalEntry *)  getJournalEntryForEntryIndex:(int)index
{
   
        return _journalEntries[index];
    
}
- (id) initWithTitleOwnerAndDefaultEntry:(NSString *)journalTitle :(JournalOwner *) jOwner
{
    // Assign journal title
    _Title = journalTitle;
    [self TimeStamp]; // When the init method is called, ensure we timeStamp
    _journalEntries = [[NSMutableArray alloc] init]; // Initialize empty array
    _Owner = jOwner; // Assign the owner
    
    // Create a default entry
    DreamJournalEntry *defaultJournalEntry = [[DreamJournalEntry alloc] initWithJournalEntryTitle:@"Welcome to your journal!"];
    defaultJournalEntry.JournalEntryText = @"This is the default entry for your dream journal. Feel free to delete it. Please check out this link for more help.";
    
    // Create a default dream character and add it
    
    int rnd = arc4random_uniform(3);
    DreamCharacter *defaultChar;
    if (rnd == 1){
    defaultChar = [[DreamCharacter alloc] initWithNameGenderAndDescription:@"Default Name" gender:female description:@"This is a female default dream character description"];
    } else  {
         defaultChar = [[DreamCharacter alloc] initWithNameGenderAndDescription:@"Default Name" gender:male description:@"This is a a default male dream character description"];
    }
    [defaultJournalEntry AddDreamCharacter:defaultChar];
    [_journalEntries addObject: defaultJournalEntry]; // Add to the array
    
    return self;
}

- (void) TimeStamp
{
    // Assign date
    _CreateDate =  [NSDate date];
    
    // Create a date formatter and then assign it to the StringCreateDate field
    /*
    NSDateFormatter *dFormatter = [[NSDateFormatter alloc] init];
    [dFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _StringCreateDate= [dFormatter stringFromDate: _CreateDate];
*/
    
}

- (JournalOwner *) getJournalOwner
{
    return _Owner;
}
// NSCoding
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject: self.Title forKey:@"Title"];
    [aCoder encodeObject: self.Owner forKey:@"Owner"];
    [aCoder encodeObject:self.journalEntries forKey:@"jEntries"];
    [aCoder encodeObject:self.CreateDate forKey:@"createDate"];
    //[aCoder encodeObject:self forKey: kObjectKey];
}
- (NSString *)getJournalOwnerFullNameAsString
{
    NSString *returnString;
    returnString = self.Owner.FirstName;
    returnString = [returnString stringByAppendingString:@" "];
    returnString = [returnString stringByAppendingString:self.Owner.LastName];
    
    return returnString;
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.Title = [aDecoder decodeObjectForKey:@"Title"];
    _Owner = [aDecoder decodeObjectForKey:@"Owner"];
    _journalEntries = [aDecoder decodeObjectForKey:@"jEntries"];
    _CreateDate = [aDecoder decodeObjectForKey:@"createDate"];
    // self = [aDecoder decodeObjectForKey: kObjectKey];
    return self;
}
- (void) setJournalEntryArray:(NSMutableArray *)entryArray
{
    if (entryArray != nil)
    {
        _journalEntries = entryArray;
    } else {
        NSException *NullReferenceException = [[NSException alloc] initWithName:@"NullReferenceException" reason:@"Journal Entry Array is null" userInfo:nil]; @throw NullReferenceException;
                                               
    }
}
 @end

@implementation JournalOwner

@synthesize FirstName = _FirstName;
@synthesize LastName = _LastName;
@synthesize DateOfBirth = _DOB;
@synthesize CreateDate = _CreateDate;

- (id)initWithOwnerFirstAndLastName:(NSString *)firstName withLastName:(NSString *)lastName withDateOfBirth:(NSDate *)dateOfBirth
{
    // Constructor
    _DOB = dateOfBirth;
    self.FirstName = firstName;
    self.LastName = lastName;
    _CreateDate = [NSDate date];
    return self;
}


- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.FirstName forKey:@"firstName"];
    [aCoder encodeObject:self.LastName forKey:@"lastName"];
    [aCoder encodeObject:self.DateOfBirth forKey:@"dob"];
    [aCoder encodeObject:self.CreateDate forKey:@"createDate"];
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.FirstName = [aDecoder decodeObjectForKey:@"firstName"];
    self.LastName = [aDecoder decodeObjectForKey:@"lastName"];
    _DOB = [aDecoder decodeObjectForKey:@"dob"];
    _CreateDate = [aDecoder decodeObjectForKey:@"createDate"];
    return self;
}
@end

