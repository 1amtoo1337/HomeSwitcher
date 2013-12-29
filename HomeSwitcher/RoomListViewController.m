//
//  ListViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "RoomListViewController.h"
#import "OutletListViewController.h"
#import "AddRoomViewController.h"
#import "Room.h"
#import "ProgressHUD.h"

@interface RoomListViewController ()

@property (nonatomic, strong) NSArray *rooms;

@end

@implementation RoomListViewController

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
    
    NSLog(@"floor: %@",self.floor.name);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) return @"Room";
    
    return @"default";
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *sectionTitle;
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
    
    sectionTitle = @"Rooms";
    label.frame = CGRectMake(5, 28, 284, 23);
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont fontWithName:@"Avenir" size:17];
    label.text = sectionTitle;
    label.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [view addSubview:label];
    
    return view;
}

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
    
    UIImageView *checkmark = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chevron.png"]];
    cell.accessoryView = checkmark;

    
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
        [ProgressHUD showSuccess:@"Room deleted"];
        
        [tableView reloadData];
        
    }
}


#pragma mark - Segue Stuff

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"listToDetailSegue"])
    {
        OutletListViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Room *room = [self.rooms objectAtIndex:indexPath.row];
        vc.room = room;
    }
    
    if([[segue identifier] isEqualToString:@"listToAddSegue"])
    {
        AddRoomViewController *vc = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
       
        vc.floor = self.floor;
        vc.delegate = self;
    }
    
}

#pragma mark - Custom Delegate Implementation

-(void)didFinishRoomInput:(AddRoomViewController *)controller
{
    NSLog(@"finished room input fired");
    [self fetchRoomsFromCoreData];
    [ProgressHUD showSuccess:@"Room added"];
    [self.tableView reloadData];
}

#pragma mark - Custom Implementation


- (IBAction)reloadData:(id)sender
{
    [self.tableView reloadData];
}

- (IBAction)addBarButtonPressed:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Create Floor", @"Create Room", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showFromBarButtonItem:sender animated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addFloor];
    }else if (buttonIndex == 1)
    {
        [self addRoom];
    }
}

-(void)addFloor
{
    UIViewController *vc=[[self storyboard] instantiateViewControllerWithIdentifier:@"AddFloorViewController"];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}


-(void)addRoom
{
    
        UIViewController *vc=[[self storyboard] instantiateViewControllerWithIdentifier:@"AddRoomViewController"];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}

-(void)fetchRoomsFromCoreData
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"floor == %@", self.floor];

    [fetchRequest setPredicate:predicate];
    
    [fetchRequest setEntity:entity];
    NSError *error;
    
    self.rooms = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}
@end
