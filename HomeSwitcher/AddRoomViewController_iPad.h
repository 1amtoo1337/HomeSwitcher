//
//  AddRoomViewController_iPad.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddOutletViewController_iPad.h"

@class AddRoomViewController_iPad;

@protocol AddRoomIpadDelegate <NSObject>

-(void)didFinishRoomInput:(AddRoomViewController_iPad *)controller room:(NSArray *)roomArray;

@end

@interface AddRoomViewController_iPad : UITableViewController<NSFetchedResultsControllerDelegate,UITextFieldDelegate, AddOutletIpadDelegate>

@property (nonatomic, weak) id<AddRoomIpadDelegate>delegate;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
