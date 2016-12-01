//
//  ViewController.m
//  BR_TablewTemplate
//
//  Created by gitBurning on 16/12/1.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "ViewController.h"
#import "BRTablewTempelte.h"
#import "CustomTableViewCell.h"
@interface ViewController ()
@property (nonatomic, strong) BRTablewTempelte *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BRTablewTempelte *temp = [[BRTablewTempelte alloc] initWithIsGrounp:YES rowType:BR_TablewBaseViewType_MoreSectionOneRow withCellInitBlcok:^UITableViewCell *(UITableView *tablew, NSIndexPath *indexPath, id model) {
        
        static NSString *cellIndexfier = @"CustomTableViewCell";
        CustomTableViewCell *cell = [tablew dequeueReusableCellWithIdentifier:cellIndexfier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellIndexfier owner:self options:nil] firstObject];
        }
        return cell;
        
    } withHeaderBlcok:^id(UITableView *tablew, NSInteger section) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        return header;
        
    } withFooderBlcok:^id(UITableView *tablew, NSInteger section) {
        return @(0.00001);
        
    } configTablew:^(UITableView *tablew) {
        [self.view addSubview:tablew];
        tablew.frame = CGRectMake(10, 10, 200, 400);
        
    }];
    
    [temp BR_updateDataArrayBlock:^NSArray *{
        
        return @[@"1",@"2"];
    }];
    
    [temp BR_addDeleteCellIndexPathBlock:^(UITableView *tablew, NSIndexPath *indexPath, UITableViewCellEditingStyle style) {
        
        NSLog(@"执行了删除");
        
    }];
    
    
    [temp BR_addDidSelectRowAtIndexPathBlcok:^(UITableView *tablew, NSIndexPath *indexPath, id model) {
       
        NSLog(@"点击了%ld",indexPath.section);
    }];
    
    self.viewModel = temp;
    

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
