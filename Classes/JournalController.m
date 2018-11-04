//
//  JournalController.m
//  Oneiro
//
//  Created by David Eastmond on 2018-02-17.
//  Copyright © 2018 David Eastmond. All rights reserved.
//

#import "JournalController.h"
#define backUpJournal @"bckup"

@implementation JournalController

+(DreamJournal *) getArchievedDreamJournal : (NSString *) forWhatKey
{
    // Method for retrieving the journal data
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:forWhatKey];
    DreamJournal *returnJournal;
    
    returnJournal = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return returnJournal;
}
+ (void) saveArchieveDreamJournal : (DreamJournal *) journalToSave
                       forWhatKey : (NSString *) key
{
    //Delete the old key
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:journalToSave];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
}
+ (bool) isSavedJournalPresent:(NSString *)forWhatKey
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:forWhatKey];
    if (data == nil)
    {
        NSLog(@"No journal found for key %@", forWhatKey);
        return false;
    }
    return true;
}
+ (void) deleteJournalArchieve:(NSString *)forWhatKey
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:forWhatKey] == nil)
    {
        // There is an error
        NSLog(@"Key does not exist or error");
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:forWhatKey];
        NSLog(@"Journal deleted");
    }
}
+ (void) addJournalEntryToJournal:(DreamJournalEntry *)entry forWhatKey:(NSString *)key
{
    DreamJournal *j = [self getArchievedDreamJournal:key];
    if (j != nil)
    {
        [j addEntryToJournal:entry];
    
    
        // Save the journal to disk
        [self saveArchieveDreamJournal:j forWhatKey:key];
    } else {
        //Nothing was saved
        NSException *NillJournalException = [[NSException alloc] initWithName:@"NillJournalEntryException" reason:@"The journal entry is nil. Unable to save." userInfo:nil];
        @throw NillJournalException;
       
    }
}
+ (NSInteger) getJournalEntryCount:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal:forWhatKey];
    NSInteger returnCount = 0;
    if (j != nil)
    {
        returnCount=  j.journalEntries.count;
    }
    return returnCount;
}
+(void) debugPrintJournalEntries:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal: forWhatKey];
    
    for (int b = 0; b <= j.journalEntries.count - 1; b++)
    {
        DreamJournalEntry *Entry = [j getJournalEntryForEntryIndex:b];
        NSLog(@"Entry %d is titled %@", b, Entry.Title);
        NSLog(@"Text reads: \n %@", Entry.JournalEntryText);
    }
}
+ (NSString *) getJournalTitle:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal:forWhatKey];
    NSString *returnTitle = j.Title;
    return returnTitle;
}
+ (NSMutableArray *) getAllDreamCharacters:(NSString *)forWhatKey
{
    DreamJournal *j = [self getArchievedDreamJournal:forWhatKey];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    if (j != nil)
    {
    // This function returns an NSMutableArray containing all the dream characters in each entry
        for (DreamJournalEntry *jEntries in j.journalEntries)
        {
            for (DreamCharacter *jChar in jEntries.dreamCharacters)
            {
                [ret addObject:jChar];
                NSLog(@"Character %@", jChar.Name);
            }
        }
    }
    // If the count is zero, return nil, otherwise return an array
    if (ret.count <= 0)
    {
        return nil;
        
    } else {
        return ret;
    }
        
}
+ (void) backUpJournalArchieveForJournal : (DreamJournal *) bckup
{
    // Back up the dreamJournal
    if (bckup != nil)
    {
        [self saveArchieveDreamJournal:bckup forWhatKey:backUpJournal];
        // Save the backup
        NSLog(@"Back-up journal saved");
    }
    else {
        // An error
        [UINotificationBanner showBannerWithMessage:@"Error backing up journal" forDuration:3];
    }
}
+ (void) resetJournalArchieve:(NSString *)forWhatKey
{
    // Deletes and resets the journal archieve
    DreamJournal *tempBackUp = [self getArchievedDreamJournal:forWhatKey];
    [self backUpJournalArchieveForJournal:tempBackUp]; // Back up
    
    [self deleteJournalArchieve:forWhatKey]; // Delete
    
    // Create a default journal
    NSDate *now = [NSDate date];
    JournalOwner *owner = [[JournalOwner alloc] initWithOwnerFirstAndLastName:@"Test First Name" withLastName:@"TestLastName" withDateOfBirth:now];
    DreamJournal *newJ = [[DreamJournal alloc] initWithTitleOwnerAndDefaultEntry:@"New Default Debug Joural" :owner];
    [self saveArchieveDreamJournal: newJ forWhatKey:forWhatKey];// Replace
}
+ (void) saveJournalEntryForEntryIndex:(NSInteger)index forEntry:(DreamJournalEntry *)entry Key:(NSString *)forKey
{
    // Saves a particular journal entry after changes are made
    // get the journal
    DreamJournal *J = [self getArchievedDreamJournal: forKey];
    if (J == nil)
    {
        NSException *err = [[NSException alloc] initWithName:@"JournalNotFoundException" reason:@"The key supplied was not found, and has returned a nill reference" userInfo:nil];
        @throw err;
    }
    if (index  < 0 || index > J.journalEntries.count)
    {
        NSException *err = [[NSException alloc] initWithName:@"InvalidJournalIndex" reason:@"The index is out of range." userInfo:nil];
        @throw err;
    }
    [J.journalEntries replaceObjectAtIndex:index withObject:entry];
    [self saveArchieveDreamJournal:J forWhatKey:forKey];
}
+ (NSArray <NSString *>*) loadDefaultDreamSignDatabase
{
    // Read the data file
    NSString *path = [NSBundle.mainBundle pathForResource:@"dreamsigns" ofType:@"txt"];
    NSMutableArray *returnValue = [[NSMutableArray alloc] init];
    @try
    {
        NSString *fileData = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSString *finalWord = @"";
        for (NSUInteger i = 0; i <= fileData.length - 1; i++)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString *r = [fileData substringWithRange:range];
            if (![r isEqualToString:@"\n"])
            {
                finalWord = [finalWord stringByAppendingString:r];
                //NSLog(@"%@", finalWord);
            } else {
                // Create a dream sign object
               
                [returnValue addObject:finalWord];
                finalWord = @"";
            }
        }
    } @catch (NSException * ex) {
        NSLog(@"%@", ex.reason);
    }
    
    // So we have loaded all of the default dream signs from the dreamsigns.txt file.
    // Now let's go through the dream journal and get all the dream signs from every journal entry
    
    DreamJournal *Jrn = [self getArchievedDreamJournal:@"journal"];
    NSArray *getAllSigns = [self getAllJournalDreamSignsForJournal:Jrn];
    NSArray *final_return = [returnValue arrayByAddingObjectsFromArray:getAllSigns];
   
    return final_return;
}
+ (NSArray *) getAllJournalDreamSignsForJournal : (DreamJournal *) refJournal
{
    // This goes through the journal and gets a nice trimmed list (array) of all dreamsigns
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    if (refJournal != nil)
    {
        for (int journalEntryIndex = 0; journalEntryIndex <= refJournal.journalEntries.count - 1; journalEntryIndex++)
        {
            // Cycle through
            for (int dreamSignEntryIndex = 0; dreamSignEntryIndex <= refJournal.journalEntries[journalEntryIndex].dreamSigns.count -1; dreamSignEntryIndex ++)
            {
                if (![refJournal.journalEntries[journalEntryIndex].dreamSigns[dreamSignEntryIndex] isEqualToString:@"default"] && refJournal.journalEntries[journalEntryIndex].dreamSigns.count > 1)
                {
                    [returnArray addObject:refJournal.journalEntries[journalEntryIndex].dreamSigns[dreamSignEntryIndex]];
                } else {
                    [returnArray addObject:refJournal.journalEntries[journalEntryIndex].dreamSigns[dreamSignEntryIndex]];
                }
            }
        }
        
        //
        NSArray *cleanArray = [[NSSet setWithArray:returnArray] allObjects]; // Remove duplicates
        NSLog(@"returning a clean array");
        return cleanArray;
    } else {
        NSException *journalIsNilException = [[NSException alloc] initWithName:@"NillDreamJournalException" reason:@"The journal provided is nil or invalid." userInfo:nil];
        @throw journalIsNilException;
    }
    
    return returnArray;
}
+ (void) saveJournalEntryForEntryArray:(NSMutableArray *)DreamJournalEntryArray forJournalEntryKey:(NSString *)forKey
{
    // Open the journal
    DreamJournal *J = [self getArchievedDreamJournal:forKey];
    
    if (J != nil){
        if (DreamJournalEntryArray != nil)
        {
         // Assign the array
            [J setJournalEntryArray:DreamJournalEntryArray];
            [self saveArchieveDreamJournal:J forWhatKey:forKey]; // Save
            NSLog(@"Journal Entry Array was saved.");
        } else {
            // Error
        }
        
    } else {
        // Error
    }
}
 @end
