//
//  AddRoomViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 09.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "AddRoomViewController.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                {
                    cell.textLabel.text = @"Name:";
                    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, 80, 30)];
                    txtField.borderStyle = UITextBorderStyleLine;
                    [cell addSubview:txtField];
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
                    cell.textLabel.text = @"Name:";
                    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, 80, 30)];
                    txtField.borderStyle = UITextBorderStyleLine;
                    [cell addSubview:txtField];
                }
                    break;
                    
                case 1:
                {
                    cell.textLabel.text = @"'ON' command:";
                    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(160, 5, 80, 30)];
                    txtField.borderStyle = UITextBorderStyleLine;
                    [cell addSubview:txtField];
                }
                    break;
                    
                case 2:
                {
                    cell.textLabel.text = @"'OFF' command:";
                    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(160, 5, 80, 30)];
                    txtField.borderStyle = UITextBorderStyleLine;
                    [cell addSubview:txtField];
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

-(void)validateInput
{
    
}
- (IBAction)dismissAddView:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
