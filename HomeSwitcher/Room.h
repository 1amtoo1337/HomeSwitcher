//
//  Room.h
//  HomeSwitcher
//
//  Created by Allan Acheampong on 13.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Lightstrip, Outlet;

@interface Room : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *outlets;
@property (nonatomic, retain) NSSet *lightstrip;
@end

@interface Room (CoreDataGeneratedAccessors)

- (void)addOutletsObject:(Outlet *)value;
- (void)removeOutletsObject:(Outlet *)value;
- (void)addOutlets:(NSSet *)values;
- (void)removeOutlets:(NSSet *)values;

- (void)addLightstripObject:(Lightstrip *)value;
- (void)removeLightstripObject:(Lightstrip *)value;
- (void)addLightstrip:(NSSet *)values;
- (void)removeLightstrip:(NSSet *)values;

@end
