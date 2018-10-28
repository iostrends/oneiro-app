//
//  DreamJournal.h
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamCharacter.h"
#import "DreamJournalEntry.h"
@class JournalOwner;
@class DreamJournalEntry;

// This is the main class
@interface DreamJournal : NSObject <NSCoding>
{
   
}

// Read Only Properties ---
@property (readonly) NSDate *CreateDate;
@property (readonly) JournalOwner *Owner;

// -----
@property NSString *Title;
@property (readonly) NSMutableArray<DreamJournalEntry *> *journalEntries;
- (NSString *) getJournalOwnerFullNameAsString; // This is going to return the journal owner's first and last name in string friendly format
- (void) addEntryToJournal : (DreamJournalEntry *) entryToAdd;
- (id) initWithTitleOwnerAndDefaultEntry : (NSString*) journalTitle : (JournalOwner *) jOwner;
- (DreamJournalEntry *) getJournalEntryForEntryIndex : (int) index;
- (void) setJournalEntryArray : (NSMutableArray *) entryArray;
@end


@interface JournalOwner : NSObject <NSCoding>
{
    
}
@property NSString *FirstName;
@property NSString *LastName;
@property (readonly) NSDate *DateOfBirth;
@property (readonly) NSDate *CreateDate;

// Constructor
- (id) initWithOwnerFirstAndLastName : (NSString *) firstName
                                     withLastName: (NSString *) lastName
                         withDateOfBirth: (NSDate *)dateOfBirth;

@end
