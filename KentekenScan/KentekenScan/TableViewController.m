//
//  TableViewController.m
//  KentekenScan
//
//  Created by Jetse Koopmans on 04/12/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import "TableViewController.h"

@implementation TableViewController {
//    NSMutableArray *results = [[NSMu]];
}
//@synthesize results;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewdidload");
    [self.results addObject:self.result];
//    self.results = [[NSMutableArray alloc]init];
//    [self.results addObject:self.result];
//    NSLog(@"Array: %@", results);
//    [TableViewController.results];
//    ViewController *viewController=[[ViewController alloc] init];
//    self.results = viewController.results;
//    NSLog(@"table view: Array: %@", viewController.results);


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewwillappear");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [viewController.results];
    return [self.results count];
//    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier =@"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text=[self.results objectAtIndex:indexPath.row];
    
    return cell;
}

@end
