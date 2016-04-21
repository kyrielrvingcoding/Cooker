//
//  SnackViewController.m
//  Cooker
//
//  Created by lanou on 16/4/21.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "SnackViewController.h"
#import "SnackClassesModel.h"
#import "SnackDetailModel.h"
#import "SnackDetailClassesModelCell.h"


@interface SnackViewController ()

@end

@implementation SnackViewController
//请求数据
- (void)requestData {
    
    NSDictionary *parameter = @{@"lat":@31.1299664191505, @"lon":@121.2840490671994, @"cid":@"天津小吃"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:HOMEDATA_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //            NSLog(@"---%@---", responseObject);
        
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"error = %@",error);
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
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
