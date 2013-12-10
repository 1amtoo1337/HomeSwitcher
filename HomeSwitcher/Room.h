//
//  Room.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 10.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Outlet;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *outlets;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addOutletsObject:(Outlet *)value;
- (void)removeOutletsObject:(Outlet *)value;
- (void)addOutlets:(NSSet *)values;
- (void)removeOutlets:(NSSet *)values;

@end
