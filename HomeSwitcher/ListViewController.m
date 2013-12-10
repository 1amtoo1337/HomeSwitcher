//
//  ListViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "ListViewController.h"
#import "OutletViewController.h"
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

    //NavBar Gradient
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = CGRectMake(0, -20, 320, 64);
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:38.0f / 255.0f green:126.0f / 255.0f blue:214.0f / 255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:99.0f / 255.0f green:165.0f / 255.0f blue:216.0f / 255.0f alpha:1.0f] CGColor], nil];
//    [gradient setStartPoint:CGPointMake(0.0, 0.5)];
//    [gradient setEndPoint:CGPointMake(1.0, 0.5)];
//    [self.navigationController.navigationBar.layer insertSublayer:gradient atIndex:0];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];

    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
    //core data
    //managedObjectContext reference
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
    
    [self addRoomTest];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    //add results to array
    self.rooms = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    Room *room = [self.rooms objectAtIndex:indexPath.row];
    cell.textLabel.text = room.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",info.city, info.state];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    
    return cell;
}


- (void)insertNewObject:(id)sender
{
    NSLog(@"Inserting");
    
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
//    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
//    
//    // If appropriate, configure the new managed object.
//    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//    [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
//    
//    // Save the context.
//    NSError *error = nil;
//    if (![context save:&error]) {
//        // Replace this implementation with code to handle the error appropriately.
//        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }
}

-(void)addRoomTest
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Room *room = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Room"
                  inManagedObjectContext:context];
    [room setValue:@"Schlafzimmer" forKey:@"name"];
    
    Outlet *outlet = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Outlet"
                      inManagedObjectContext:context];
    outlet.name = @"Stehlampe";
    outlet.state = 0;
    outlet.room = room;

    
    Command *command = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Command"
                        inManagedObjectContext:context];
    command.on = @"C/ONN";
    command.off = @"C/OFF";
    command.outlet = outlet;
    outlet.command = command;
    
    Outlet *outlet1 = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Outlet"
                      inManagedObjectContext:context];
    outlet1.name = @"Stehlampe1";
    outlet1.state = 0;
    outlet1.room = room;
    
    
    Command *command1 = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Command"
                        inManagedObjectContext:context];
    command1.on = @"C/ONN";
    command1.off = @"C/OFF";
    command1.outlet = outlet1;
    outlet1.command = command1;
    
    
    [room.outlets setByAddingObjectsFromArray:@[outlet, outlet1]];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"listToDetailSegue"])
    {
        OutletViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        Room *room = [self.rooms objectAtIndex:indexPath.row];
        vc.room = room;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
