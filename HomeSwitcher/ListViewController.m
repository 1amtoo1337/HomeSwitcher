//
//  ListViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "ListViewController.h"
#import "OutletViewController.h"
#import "AddRoomViewController.h"
#import "Room.h"
#import "Outlet.h"
#import "Command.h"

@interface ListViewController ()

@property (nonatomic, strong) NSArray *rooms;

@end

@implementation ListViewController

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

    [self fetchRoomsFromCoreData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Room *room = [self.rooms objectAtIndex:indexPath.row];
    cell.textLabel.text = room.name;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
                Room *room = [self.rooms objectAtIndex:indexPath.row];
        
                [self.managedObjectContext deleteObject:room];
    
                NSError *error = nil;
                if (![self.managedObjectContext save:&error])
                {
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                }
        [self fetchRoomsFromCoreData];
        
        [tableView reloadData];
        
    }
}


#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"listToDetailSegue"])
    {
        OutletViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Room *room = [self.rooms objectAtIndex:indexPath.row];
        vc.room = room;
    }
    
    if([[segue identifier] isEqualToString:@"listToAddSegue"])
    {
        AddRoomViewController *vc = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
       
        vc.delegate = self;
    }
    
}

#pragma mark - Custom Implementation

-(void)didFinishRoomInput:(AddRoomViewController *)controller
{
    NSLog(@"finished room input fired");
    [self fetchRoomsFromCoreData];
    [self.tableView reloadData];
}


- (IBAction)reloadData:(id)sender
{
    [self.tableView reloadData];
}

-(void)fetchRoomsFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.rooms = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}
@end
