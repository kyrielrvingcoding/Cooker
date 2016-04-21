//
//  MyselfViewController.m
//  Cooker
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 class17. All rights reserved.
//

#import "MyselfViewController.h"
#import "MyselfHeaderView.h"

@interface MyselfViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation MyselfViewController

- (void)requestData {

    NSDictionary *parameter = @{@"frienduid":@"16493440",@"version":@"12.2.1.0"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:SELECTUSER_URL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//       NSLog(@"---%@---", responseObject);
        
        /* 这都是啥
         article = 0;
         collection = 0;
         enjoyWeibo = 0;
         fans = 41;
         follow = 1;
         id = "";
         pic = 18867402;
         profile = "";
         recommend = 0;
         region = "";
         sex = 0;
         title = "yoonjae_\U5e3d\U5e3d";
         uid = 16493440;
         userContent = 0;*/
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"error = %@",error);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    
    [self createTableView];
   

   
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
    
    MyselfHeaderView *myheaderView = [[[NSBundle mainBundle] loadNibNamed:@"MyselfHeaderView" owner:nil options:nil] lastObject];
    myheaderView.frame = CGRectMake(0, 0, SCREENWIDTH, 300);
    _tableView.tableHeaderView = myheaderView;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *string = @"str";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:string];
    }
    NSArray *array = @[@"专辑",@"菜谱",@"厨说"];
    cell.textLabel.text = array[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"ms_caipu_level_un"];
    cell.detailTextLabel.text = @"0";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = NO;
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
}
@end
