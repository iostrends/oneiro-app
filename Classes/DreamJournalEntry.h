//
//  DreamJournalEntry.h
//  Oneiro
//
//  Created by David Eastmond on 2017-10-01.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamCharacter.h"

@class DreamCharacter;


// Journal Entries
@interface DreamJournalEntry : NSObject <NSCoding>
{
}
@property (readonly) NSDate *CreateDate;
@property NSString *Title;

@property (readonly) NSMutableArray <DreamCharacter *> *dreamCharacters; // This holds an array of dreamCharacters
@property (readonly) NSMutableArray <NSString *> *dreamSigns; // Holds list of dream signs
@property NSString *JournalEntryText;

// Constructor
- (id) initWithJournalEntryTitle : (NSString *) entryTitle;

// We need a method that adds dream characters to the array
- (void) AddDreamCharacter : (DreamCharacter *) charToAdd;
- (void) AddDreamSign : (NSString *) dreamSignToAdd;
- (void) AddDreamSignByArray : (NSArray *) arrayToAdd;
- (void) AddDreamSignByMutableArray: (NSMutableArray *) arrayToAdd;
- (bool) isIDInJournalEntry : (NSString *) charID; // This is a method that checks if a dreamCharacter with a particular ID is in this journalEntry's array
@end




// Journal Edit update bundle
@interface JournalEditBundle : NSObject
{
}
- (id) initWithJournalEntry : (DreamJournalEntry *) Entry forIndex: (NSInteger) index;
@property NSInteger EntryIndex;
@property (strong, nonatomic) DreamJournalEntry *JournalEntryReference;
@end
