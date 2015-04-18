//
//  SDDateDetailViewController.m
//  SignificantDates
//
//  Created by Chris Wagner on 6/1/12.
//

#import "SDDateDetailViewController.h"

#import "LostDogs.h"
#import "SDCoreDataController.h"

enum SDDateType {
    SDDateLostDogs,
   // SDDateBirthday
    };

typedef enum {
    SDLostDogsDateCell = 0,
    SDLostDogsDetailsCell = 1,
    SDLostDogsLocationCell = 2,
    SDLostDogsUserNameCell = 3
    } SDLostDogsCell;

/*typedef enum {
    SDBirthdayDateCell = 0,
    SDBirthdayGiftIdeasCell = 1,
    SDBirthdayFacebookCell = 2
}
 SDBirthdayCell;
*/
@interface SDDateDetailViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (strong, nonatomic) NSManagedObject *managedObject;

@property enum SDDateType dateType;

@end

@implementation SDDateDetailViewController
@synthesize context;
@synthesize managedObject;
@synthesize dateType;
@synthesize managedObjectId;
@synthesize imageView;
@synthesize detailTableView;

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
    
    self.context = [[SDCoreDataController sharedInstance] newManagedObjectContext];
    self.managedObject = [context objectWithID:self.managedObjectId];
    
    self.title = [self.managedObject valueForKey:@"petName"];
    self.imageView.image = [UIImage imageWithData:[self.managedObject valueForKey:@"photo"]];
   // if ([self.managedObject isKindOfClass:[LostDogs class]]) {
        self.dateType = SDDateLostDogs;
   // } else {
      //  self.dateType = SDDateBirthday;
  // }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setDetailTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"DateDetailViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
        LostDogs *lostDogs = (LostDogs *)self.managedObject;
        if (indexPath.row == SDLostDogsDateCell) {
            cell.textLabel.text = @"Date&Time";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:lostDogs.dateTime];
        } else if (indexPath.row == SDLostDogsDetailsCell) {
            cell.textLabel.text = @"Pet name";
            cell.detailTextLabel.text = lostDogs.petName;
        } else if (indexPath.row == SDLostDogsLocationCell) {
            cell.textLabel.text = @"Location";
            cell.detailTextLabel.text = cell.detailTextLabel.text = lostDogs.petName;
        } else if (indexPath.row == SDLostDogsUserNameCell) {
            cell.textLabel.text = @"username";
            
        }
    
            /*
    } else if (dateType == SDDateBirthday) {
        Birthday *birthday = (Birthday *)self.managedObject;
        if (indexPath.row == SDBirthdayDateCell) {
            cell.textLabel.text = @"Date";
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:birthday.date];
        } else if (indexPath.row == SDBirthdayGiftIdeasCell) {
            cell.textLabel.text = @"Gift Ideas";
            cell.detailTextLabel.text = birthday.giftIdeas;
        } else if (indexPath.row == SDBirthdayFacebookCell) {
            cell.textLabel.text = @"Facebook";
            if (![birthday.facebook isEqualToString:@""]) {
                cell.detailTextLabel.text = birthday.facebook;
            } else {
                cell.detailTextLabel.text = @"Search Facebook";
            }
        }  */
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    if (self.dateType == SDDateLostDogs) {
        rows = 4;
    //else if (self.dateType == SDDateBirthday) {
     //   rows = 3;
   // }
}
    return rows;
}



@end
