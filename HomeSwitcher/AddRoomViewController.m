//
//  AddRoomViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddRoomViewController.h"
#import "InputCell.h"
#import "Room.h"
#import "Outlet.h"
#import "Command.h"

@interface AddRoomViewController ()

@property int numberOfOutlets;

@end

@implementation AddRoomViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //NavBar Gradient
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = CGRectMake(0, -20, 320, 64);
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:38.0f / 255.0f green:126.0f / 255.0f blue:214.0f / 255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:99.0f / 255.0f green:165.0f / 255.0f blue:216.0f / 255.0f alpha:1.0f] CGColor], nil];
//    [gradient setStartPoint:CGPointMake(0.0, 0.5)];
//    [gradient setEndPoint:CGPointMake(1.0, 0.5)];
//    [self.navigationController.navigationBar.layer insertSublayer:gradient atIndex:1];
    
    //navigationItem Image
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 98, 34)];
    navigationImage.image=[UIImage imageNamed:@"navTitle.png"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 98, 34)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView = workaroundImageView;
    
    //self.numberOfOutlets = 2;
    
    
    //core data
    //managedObjectContext reference
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = delegate.managedObjectContext;
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
    if(section == 1) return @"Outlets";
    
    return @"";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0) return 1;
    if(section == 1) return 3 + self.numberOfOutlets;
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    cell.nameLabel.text = @"Name:";
                    cell.textField.delegate = self;
                    cell.textField.tag = 11;
                    
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        case 1:
            switch (indexPath.row) {
                case 0:
                {
                    cell.nameLabel.text = @"Name:";
                    cell.textField.delegate = self;
                    cell.textField.tag = 12;
                }
                    break;
                    
                case 1:
                {
                    cell.nameLabel.text = @"'ON' command:";
                    cell.textField.delegate = self;
                    cell.textField.tag = 13;
                }
                    break;
                    
                case 2:
                {
                    cell.nameLabel.text = @"'OFF' command:";
                    cell.textField.delegate = self;
                    cell.textField.tag = 14;
                }
                    break;
                    
                default:
                    break;
            }
            break;
            
        default:
            break;
    }
    //cell.textLabel.text = @"Add some stuff";
    
    return cell;
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

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 11) NSLog(@"first text");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{

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

- (IBAction)validateInput:(UIBarButtonItem *)sender
{
    NSString *roomName = ((UITextField*)[self.view viewWithTag:11]).text;
    NSString *outletName = ((UITextField*)[self.view viewWithTag:12]).text;
    NSString *outletOn = ((UITextField*)[self.view viewWithTag:13]).text;
    NSString *outletOff = ((UITextField*)[self.view viewWithTag:14]).text;
    
    //this fuction needs to trigger a delegate method that reloads the listView tableView
    if([roomName isEqualToString:@""] || [outletName isEqualToString:@""] || [outletOn isEqualToString:@""] || [outletOff isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter all Fields" message:@"Not all fields were entered" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
    }else if(![roomName isEqualToString:@""] && ![outletName isEqualToString:@""] && ![outletOn isEqualToString:@""] && ![outletOff isEqualToString:@""])
    {
        [self saveData];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(void)saveData
{
    NSString *roomName = ((UITextField*)[self.view viewWithTag:11]).text;
    NSString *outletName = ((UITextField*)[self.view viewWithTag:12]).text;
    NSString *outletOn = ((UITextField*)[self.view viewWithTag:13]).text;
    NSString *outletOff = ((UITextField*)[self.view viewWithTag:14]).text;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    Room *room = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Room"
                  inManagedObjectContext:context];
    [room setValue:roomName forKey:@"name"];
    
    Outlet *outlet = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Outlet"
                      inManagedObjectContext:context];
    outlet.name = outletName;
    outlet.state = 0;
    outlet.room = room;
    
    
    Command *command = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Command"
                        inManagedObjectContext:context];
    command.on = outletOn;
    command.off = outletOff;
    command.outlet = outlet;
    outlet.command = command;

    [room.outlets setByAddingObjectsFromArray:@[outlet]];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
}


- (IBAction)dismissAddView:(UIBarButtonItem *)sender
{
    NSString *text = ((UITextField*)[self.view viewWithTag:11]).text;
    NSString *text1 = ((UITextField*)[self.view viewWithTag:12]).text;
    NSString *text2 = ((UITextField*)[self.view viewWithTag:13]).text;
    NSString *text3 = ((UITextField*)[self.view viewWithTag:14]).text;
    
    /*
     
     if any of the fields have text ask the user
     
     if there is no text dismiss view
     */
    if(![text isEqualToString:@""] || ![text1 isEqualToString:@""] || ![text2 isEqualToString:@""] || ![text3 isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cancel" message:@"Are you sure you want to cancel?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok" , nil];
        [alert show];
        
    }else if([text isEqualToString:@""] || [text1 isEqualToString:@""] || [text2 isEqualToString:@""] || [text3 isEqualToString:@""])
    {
        [self dismissViewControllerAnimated:YES completion:nil];

    }
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    } else if (buttonIndex == 1)
    {
        NSLog(@"ok");
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:self];
    }
}
@end
