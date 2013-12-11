//
//  Outlet.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 11.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Command, Room;

@interface Outlet : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) Command *command;
@property (nonatomic, retain) Room *room;

@end
