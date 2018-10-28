//
//  JournalController.h
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DreamJournal.h"
#import "UINotificationBanner.h"
#import "DreamJournalEntry.h"

@class DreamJournal;
@class DreamJournalEntry;

@interface JournalController : NSObject
{
}
// Class methods
+ (DreamJournal *) getArchievedDreamJournal : (NSString *) forWhatKey;

+ (void) saveArchieveDreamJournal : (DreamJournal *) journalToSave
                       forWhatKey : (NSString *) key;

+ (void) deleteJournalArchieve : (NSString *) forWhatKey;
+ (bool) isSavedJournalPresent : (NSString *) forWhatKey;
+ (void) addJournalEntryToJournal : (DreamJournalEntry *) entry forWhatKey : (NSString *) key;
+ (NSInteger) getJournalEntryCount : (NSString *) forWhatKey;
+ (void) debugPrintJournalEntries : (NSString *) forWhatKey;

+ (void) resetJournalArchieve : (NSString *) forWhatKey;
+ (NSString *) getJournalTitle : (NSString *) forWhatKey;
+ (NSMutableArray *) getAllDreamCharacters : (NSString *) forWhatKey;
+ (void) saveJournalEntryForEntryIndex : (NSInteger) index forEntry : (DreamJournalEntry *) entry Key : (NSString *) forKey;
+ (void) saveJournalEntryForEntryArray : (NSMutableArray *) DreamJournalEntryArray forJournalEntryKey : (NSString *) forKey;
+ (NSMutableArray <NSString *>*) loadDefaultDreamSignDatabase; // Read from data file
@end
