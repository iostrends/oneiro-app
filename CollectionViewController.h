//
//  CollectionViewController.h
//  Oneiro
//
//  Created by David Eastmond on 2017-10-08.
//  Copyright © 2017 David Eastmond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DreamJournalEntry.h"
#import "CollectionViewCell.h"

@interface CollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *Journals;
}

@end
