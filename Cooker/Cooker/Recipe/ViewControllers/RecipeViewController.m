//
//  RecipeViewController.m
//  Cooker
//
//  Created by 诸超杰 on 16/4/19.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "RecipeViewController.h"
#import "TYCircleCell.h"
#import "TYCircleMenu.h"

@interface RecipeViewController () <TYCircleMenuDelegate>

@end

@implementation RecipeViewController

- (void)requestData {
    NSDictionary *parameter = @{@"version":@"12.2.1.0"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:RECIPEHOME_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---%@---", responseObject);
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCircleMenu];
    [self createTypeImageView];
    [self requestData];
}

- (void)createTypeImageView {
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH / 2, 55)];
    
    UIImageView *hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENWIDTH / 2, 64, SCREENWIDTH / 2, 60)];
    
    [self.view addSubview:newImageView];
    [self.view addSubview:hotImageView];
}

- (void)createCircleMenu {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    imageView.image = [UIImage imageNamed:@"beijingtupian04"];
    imageView.userInteractionEnabled = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 180)];
    label.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:1.0 blue:156 / 255.0 alpha:1.0];
    [imageView addSubview:label];
    [self.view addSubview:imageView];
    self.items = @[@"热门分类", @"一日三餐", @"主食小吃", @"孕婴食谱", @"宴会宴请", @"家常菜谱", @"烘焙甜点", @"美容养颜"];
    TYCircleMenu *menu = [[TYCircleMenu alloc] initWithRadious:300 itemOffset:0 imageArray:self.items titleArray:self.items cycle:YES menuDelegate:self];
    [imageView addSubview:menu];
}

- (void)selectMenuAtIndex:(NSInteger)index {
    NSLog(@"选中:%zd",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
