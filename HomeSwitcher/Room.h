//
//  Room.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lightstrip, Outlet;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * timestamp;
@property (nonatomic, retain) NSSet *lightstrip;
@property (nonatomic, retain) NSSet *outlets;
@property (nonatomic, retain) NSManagedObject *floor;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addLightstripObject:(Lightstrip *)value;
- (void)removeLightstripObject:(Lightstrip *)value;
- (void)addLightstrip:(NSSet *)values;
- (void)removeLightstrip:(NSSet *)values;

- (void)addOutletsObject:(Outlet *)value;
- (void)removeOutletsObject:(Outlet *)value;
- (void)addOutlets:(NSSet *)values;
- (void)removeOutlets:(NSSet *)values;

@end
