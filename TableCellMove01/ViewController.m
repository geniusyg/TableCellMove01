//
//  ViewController.m
//  TableCellMove01
//
//  Created by SDT-1 on 2014. 1. 6..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#define CELL_ID @"CELL_ID"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userInput;
@property (weak, nonatomic) IBOutlet UITableView *table;


@end

@implementation ViewController {
	NSMutableArray *data;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
	cell.textLabel.text = [data objectAtIndex:indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		[data removeObjectAtIndex:indexPath.row];
		NSArray *rows = [NSArray arrayWithObject:indexPath];
		[self.table deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	NSObject *obj = [data objectAtIndex:sourceIndexPath.row];
	[data removeObjectAtIndex:sourceIndexPath.row];
	[data insertObject:obj atIndex:destinationIndexPath.row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	data = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender {
	NSString *inputStr = self.userInput.text;
	if(inputStr.length > 0) {
		
		[data addObject:inputStr];
		
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([data count]-1) inSection:0];
		NSArray *row = [NSArray arrayWithObject:indexPath];
		
		[self.table insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationAutomatic];
		
		self.userInput.text=@"";
		
	}
}


- (IBAction)toggleEditMode:(id)sender {
	self.table.editing = !self.table.editing;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	[self addItem:nil];
	return YES;
}

@end





























