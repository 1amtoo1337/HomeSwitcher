//
//  RoomListViewController_iPad.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 29.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "RoomListViewController_iPad.h"
#import "AddFloorAndRoomViewController_iPad.h"
#import "SettingsViewController_iPad.h"
#import "Floor.h"
#import "Room.h"

@interface RoomListViewController_iPad ()

@property (nonatomic, strong) NSArray *floors;

@end

@implementation RoomListViewController_iPad

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //core data
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [self fetchFloorsFromCoreData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinishRoomInput)
                                                 name:@"didFinishRoomInputNotification"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Floor *floor = [self.floors objectAtIndex:section];
    
    return floor.name;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.floors.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    Floor *floor = [self.floors objectAtIndex:section];
    
    return floor.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Floor *floor = [self.floors objectAtIndex:indexPath.section];
    NSSortDescriptor * sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject: sortByName];
    NSArray *arr = [[floor.rooms allObjects] sortedArrayUsingDescriptors:sortDescriptors];
    
    Room *room = [arr objectAtIndex:indexPath.row]; //#bug# due to nsset no fitered set is available, we need assurance that we always have the same order
    
    cell.textLabel.text = room.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Sectmmion: '%i' Row: '%i'",indexPath.section, indexPath.row);
    
}

-(void)fetchFloorsFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Floor" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.floors = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    [self.tableView reloadData];
    
}


- (IBAction)addFloorAndRoomButtonPressed:(UIBarButtonItem *)sender
{
    //AddFloorAndRoomViewController_iPad *vc = [[AddFloorAndRoomViewController_iPad alloc] initWithStyle:UITableViewStyleGrouped];
    
    //UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    UINavigationController *vc=[[self storyboard] instantiateViewControllerWithIdentifier:@"floorAndRoomAddNavController"];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;

    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
    
}

- (IBAction)displaySettingsButtonPressed:(UIBarButtonItem *)sender
{
    SettingsViewController_iPad *vc = [[SettingsViewController_iPad alloc] initWithStyle:UITableViewStyleGrouped];

    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    vc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered  target:self action:@selector(doneButtonClicked)];
    [vc setTitle:@"Settings"];
    [self.navigationController presentViewController:nc animated:YES completion:nil];
}

-(void)doneButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didFinishRoomInput
{
    [self fetchFloorsFromCoreData];
}
@end
