//
//  ViewController.m
//  ASTableViewSearch
//
//  Created by Alex Sergienko on 28.02.15.
//  Copyright (c) 2015 Alexandr Sergienko. All rights reserved.
//

#import "ViewController.h"
#import "ASStudent.h"
#import "ASSection.h"
#import "ASStudentInfoViewController.h"

typedef enum ASSortType: NSUInteger{
    ASSortDate,
    ASSortFirstName,
    ASSortLastName
}ASSortType;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>

@property (weak,   nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray     *studentsArray;
@property (strong, nonatomic) NSArray     *sectionsArray;
@property (assign, nonatomic) NSInteger   choosenControlState;
@property (strong, nonatomic) NSOperation *currentOperation;
@property (strong, nonatomic) UIImage     *imageStudent;
@property (weak,   nonatomic) UIActivityIndicatorView *indicator;

@end


@implementation ViewController

-(void)loadView {
    [super loadView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:@[@"BirthDate",@"FirstName",@"Lastname"]];
    [control addTarget:self
                action:@selector(sortStudentControl:)
      forControlEvents:UIControlEventValueChanged];
    
    control.selectedSegmentIndex = ASSortDate;
    self.choosenControlState = ASSortDate;
    self.navigationItem.titleView = control;

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                     target:self
                                                     action:@selector(searchShow:)];
    self.navigationItem.leftBarButtonItem = barItem;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *studentImg = [UIImage imageNamed:@"student.png"];
    CGSize imageSize = {20, 20};
    studentImg = [self imageWithImage:studentImg convertToSize:imageSize];
    self.imageStudent = studentImg;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < 1000; i ++) {
        ASStudent *newStudent = [ASStudent createNewStudent];
        [tempArray addObject:newStudent];
    }
    self.studentsArray = tempArray;
    
    [self.indicator startAnimating];
    [self sortArrayOfStudents:tempArray  bySortType:ASSortDate];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Private methods -

- (void)searchShow: (UIBarButtonItem *) sender {
    
    UIBarButtonSystemItem currentSystemItem = UIBarButtonSystemItemEdit;
    
    if ([self.navigationItem.titleView isKindOfClass:[UISearchBar class]]) {
        currentSystemItem = UIBarButtonSystemItemSearch;
        
        UISegmentedControl *segmentedContol = [[UISegmentedControl alloc]initWithItems:@[@"BirthDate",@"FirstName",@"LastName"]];
        [segmentedContol addTarget:self
                            action:@selector(sortStudentControl:)
                  forControlEvents:UIControlEventValueChanged];
        segmentedContol.selectedSegmentIndex = self.choosenControlState;
        self.navigationItem.titleView = segmentedContol;
    
    }else{
     
        UISearchBar *setSearchBar = [[UISearchBar alloc]init];
        
        self.searchBar = setSearchBar;
        self.searchBar.delegate = self;
        self.navigationItem.titleView = self.searchBar;
    }
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:currentSystemItem
                                                                             target:self
                                                                             action:@selector(searchShow:)];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
}


- (void)sortStudentControl:(UISegmentedControl *)sender {
    
    ASSortType sortType = self.choosenControlState = sender.selectedSegmentIndex;
    
    [self sortArrayOfStudents:self.studentsArray bySortType:sortType];
    
}


- (void) sortArrayOfStudents:(NSArray*) array bySortType: (ASSortType) sortType {
    
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescroptor  = [[NSSortDescriptor alloc]initWithKey:@"lastName"  ascending:YES];
    NSSortDescriptor *birthDateDescroptor = [[NSSortDescriptor alloc]initWithKey:@"birthDate" ascending:YES];
    
    NSArray *arrayOfDescriptors = [NSArray array];
    
    switch (sortType) {
        case ASSortDate:
            arrayOfDescriptors = @[birthDateDescroptor,firstNameDescriptor,lastNameDescroptor];
            break;
            
        case ASSortFirstName:
            arrayOfDescriptors  = @[firstNameDescriptor,lastNameDescroptor,birthDateDescroptor];
            break;
            
        case ASSortLastName:
            arrayOfDescriptors = @[lastNameDescroptor,firstNameDescriptor,birthDateDescroptor];
            break;
            
        default:
            break;
    }
    
    self.studentsArray = [array sortedArrayUsingDescriptors:arrayOfDescriptors];
    
    [self generateSectionsInBackgroundFromArray:self.studentsArray andFilterString:self.searchBar.text];
    
    [self.tableView reloadData];
}


- (void) generateSectionsInBackgroundFromArray:(NSArray *) array andFilterString: (NSString *) filterString{
    
    [self.indicator startAnimating];
    
    [self.currentOperation cancel];
    __weak ViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSArray *sectionsArray = [self generateSectionsFromArray:array andFilterString:filterString];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sectionsArray = sectionsArray;
            [self.tableView reloadData];
            [self.indicator stopAnimating];
            self.currentOperation = nil;
        });
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:self.currentOperation];
}


- (NSArray*) generateSectionsFromArray:(NSArray*)array andFilterString:(NSString*)filterString{
    
    NSMutableArray* sectionsArray = [NSMutableArray array];
    
    NSString* currentLetter = nil;
    
    for (ASStudent* std in array) {
        if ([filterString length] > 0 && [std.firstName rangeOfString:filterString options:NSCaseInsensitiveSearch].location == NSNotFound && [std.lastName rangeOfString:filterString options:NSCaseInsensitiveSearch].location == NSNotFound) {
            continue;
        }
        
        NSString *firstLetter;
        
        if (self.choosenControlState == ASSortDate) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy"];
            firstLetter = [formatter stringFromDate:std.birthDate];
        } else if (self.choosenControlState == ASSortFirstName) {
            firstLetter = [std.firstName substringToIndex:1];
        } else if (self.choosenControlState == ASSortLastName) {
            firstLetter = [std.lastName substringToIndex:1];
        }
        
        ASSection* section = nil;
        
        
        if (![currentLetter isEqualToString:firstLetter]) {
            section = [[ASSection alloc] init];
            section.name = firstLetter;
            section.itemsArray = [NSMutableArray array];
            currentLetter = firstLetter;
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        [section.itemsArray addObject:std];
    }
    
    if ([sectionsArray count] == 0) {
        
        [self showAlertMessageBasedOnSearchString:filterString];
    }
    return sectionsArray;
}


- (void) showAlertMessageBasedOnSearchString:(NSString*) filterString {
    
    NSString *message = [NSString stringWithFormat:@"Sorry,there is no results with <%@>  search will back to valid state",filterString];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Search info"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
     
                           handler:^(UIAlertAction * action) {
                               NSInteger validIndexOfString = filterString.length - 1;
                               NSString *validString = [filterString substringToIndex:validIndexOfString];
                               
                               [self generateSectionsInBackgroundFromArray:self.studentsArray andFilterString:validString];
                           }];
    [alert addAction:defaultAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
        
        self.searchBar.text = [self.searchBar.text substringToIndex:self.searchBar.text.length - 1];
    });

}



- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}



#pragma mark - UITableViewDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sectionsArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    ASSection *sectionInTable = [self.sectionsArray objectAtIndex:section];
    
    return [sectionInTable.itemsArray count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[self.sectionsArray objectAtIndex:section] name];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                     reuseIdentifier:cellIdentifier];
    }
    
    ASSection *section = [self.sectionsArray objectAtIndex:indexPath.section];
    
    ASStudent *student = [section.itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName,student.lastName];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:student.birthDate];
    cell.imageView.image = self.imageStudent;
    
    return cell;
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    NSMutableArray *sectionsNamesArray = [NSMutableArray array];
    
    for (ASSection *section in self.sectionsArray){
        [sectionsNamesArray addObject:section.name];
    }
    return sectionsNamesArray;
}


#pragma mark - UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ASStudentInfoViewController *stdInfoContr = [self.storyboard instantiateViewControllerWithIdentifier:@"ASStudentInfoViewController"];
    
    ASSection *currentSection = [self.sectionsArray objectAtIndex:indexPath.section];
    ASStudent *std = [currentSection.itemsArray objectAtIndex:indexPath.row];
        
    stdInfoContr.image     = std.stdImage;
    stdInfoContr.phrase    = std.studentPhrase;
    stdInfoContr.firstName = std.firstName;
    stdInfoContr.lastName  = std.lastName;
    stdInfoContr.date      = std.birthDate;
   
    [self.navigationController pushViewController:stdInfoContr animated:YES];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CATransform3D transform;
    transform = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    transform.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blueColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = transform;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView commitAnimations];
    
}


#pragma mark - UISearchBarDelegate -

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    [self.indicator startAnimating];
    [self generateSectionsInBackgroundFromArray:self.studentsArray andFilterString:self.searchBar.text];
}

@end
