//
//  RoomDisplayViewController.m
//  HomeSwitcher
//
//  Created by Allan Acheampong on 30.12.13.
//  Copyright (c) 2013 Allan Adjei Acheampong. All rights reserved.
//

#import "RoomDisplayViewController.h"

@interface RoomDisplayViewController ()
@property BOOL pictureAddButtonEnabled;

@end

@implementation RoomDisplayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initializeTopView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return @"asdf";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
 
    return cell;
}

#pragma mark - TopView Customization
-(void)initializeTopView
{
    
    //init imageView
    [self.headerImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(togglePictureButton)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.headerImageView addGestureRecognizer:tap];
    
    //if there is a picture, load the picture into an image view
    if([self hasAvailablePictureForRoom])
    {
        
        
        [self loadPictureForCurrentRoom];
    }else
    {
        self.pictureAddButtonEnabled = YES;
        
        [self loadDefaultPictureForRoom];
    }
    
    //if there is no picture, load the default picture
}

-(BOOL)hasAvailablePictureForRoom
{
    return NO;
}

-(void)loadDefaultPictureForRoom
{
    self.headerImageView.image = [UIImage imageNamed:@"topView_placeholder.png"];
}

-(void)loadPictureForCurrentRoom
{
    NSLog(@"loading the appropriate picture for room");
}

- (IBAction)pictureAddButtonPressed:(UIButton *)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

       if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentViewController: imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.headerImageView setImage:image];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self dismissViewControllerAnimated:YES completion:nil];

    [self saveImageToFilesystem:image];
    [self togglePictureButton];
}

-(void)togglePictureButton
{
    //this is REALLY REALLY bad fix ASAP #task#
    if(self.pictureAddButtonEnabled)
    {
       self.pictureAddButton.hidden = YES;
        self.pictureAddButtonEnabled = NO;
    }else if(!self.pictureAddButtonEnabled)
    {
        self.pictureAddButton.hidden = NO;
        self.pictureAddButtonEnabled = YES;
    }
}


#pragma mark - Core Data Implementation

-(void)saveImageToFilesystem:(UIImage *) image
{
    //make this threaded, it sucks balls #task#
    
        NSLog(@"This should be a block");
    
    // Create paths to output images
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/RoomPictures/01.png"];
    //NSString  *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/RoomPictures/01.jpg"];
    
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    //[UIImageJPEGRepresentation(image, 1.0) writeToFile:jpgPath atomically:YES];
    
    // Write image to PNG
    [UIImagePNGRepresentation(image) writeToFile:pngPath atomically:YES];
    
    // Let's check to see if files were successfully written...
    
    // Create file manager
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    // Point to Document directory
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/RoomPictures/"];
    
    // Write out the contents of home directory to console
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
    
    
}




@end
