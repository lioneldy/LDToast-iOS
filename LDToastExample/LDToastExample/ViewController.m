//
//  ViewController.m
//  LDToastExample
//
//  Created by lioneldy on 2016/12/7.
//  Copyright © 2016年 lioneldy. All rights reserved.
//

#import "ViewController.h"
#import "LDToast.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"LDToastExample";
    // Do any additional setup after loading the view from its nib.
}

-(NSArray *)dataArr {
    if(_dataArr==nil) {
        _dataArr = @[@[@"中间显示",@"中间显示+自定义停留时间"],
                     @[@"顶端显示",@"顶端显示+自定义停留时间",@"顶端显示+自定义距顶端距离",@"顶端显示+自定义距顶端距离+自定义停留时间"],
                     @[@"底部显示",@"底部显示+自定义距底部距离+自定义停留时间",@"下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间",@"下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小",@"下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色",@"下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色+高亮字体颜色"],
                     @[@"左下方显示高亮文字"],
                     ];
    }
    return _dataArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataArr[section];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSArray *arr = self.dataArr[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.numberOfLines=0;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray *arr = self.dataArr[indexPath.section];
    NSString *text = arr[indexPath.row];
    if(indexPath.section==0) {
        if(indexPath.row==0) {
            /**
             *  中间显示
             */
            [LDToast showCenterWithText:text];
        }
        else if (indexPath.row==1) {
            /**
             *  中间显示+自定义停留时间
             */
            [LDToast showCenterWithText:text duration:3.0];
        }
    }
    else if (indexPath.section==1) {
        if(indexPath.row==0) {
            /**
             *  顶端显示
             */
            [LDToast showTopWithText:text];
        }
        else if (indexPath.row==1) {
            /**
             *  顶端显示+自定义停留时间
             */
            [LDToast showTopWithText:text duration:3.0];
        }
        else if (indexPath.row==2) {
            /**
             *  顶端显示+自定义距顶端距离
             */
            [LDToast showTopWithText:text topOffset:120.0];
        }
        else if (indexPath.row==3) {
            /**
             *  顶端显示+自定义距顶端距离+自定义停留时间
             */
            [LDToast showTopWithText:text topOffset:120.0 duration:3.0];
        }
        
    }
    else if (indexPath.section==2) {
        if(indexPath.row==0) {
            /**
             *  底部显示
             */
            [LDToast showBottomWithText:text];
        }
        else if (indexPath.row==1) {
            /**
             *  底部显示+自定义距顶端距离+自定义停留时间
             */
            [LDToast showBottomWithText:text offset:150 duration:5];
        }
        else if (indexPath.row==2) {
            /**
             *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间
             */
            [LDToast showBottomWithText:text offset:150 duration:5 highlightRange:NSMakeRange(17, 2)];
        }
        else if (indexPath.row==3) {
            /**
             *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小
             */
            [LDToast showBottomWithText:text offset:150 duration:5 highlightRange:NSMakeRange(17, 2) fontSize:8];
        }
        else if (indexPath.row==4) {
            /**
             *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色
             */
            [LDToast showBottomWithText:text offset:150 duration:5 highlightRange:NSMakeRange(17, 2) fontSize:8 textColor:[UIColor greenColor]];
        }
        else if (indexPath.row==5) {
            /**
             *  下方显示+自定义距底端距离+自定义高亮文字+自定义停留时间+字体大小+字体颜色+高亮字体颜色
             */
            [LDToast showBottomWithText:text offset:150 duration:5 highlightRange:NSMakeRange(17, 2) fontSize:20 textColor:[UIColor greenColor] highlightColor:[UIColor redColor]];
        }
    }
    else if(indexPath.section==3) {
        if(indexPath.row==0) {
            /**
             *  左下方显示高亮文字
             */
            [LDToast showToastAtLeftBottomWithText:text duration:3.f highlightRange:NSMakeRange(5, 2)];
        }
    }
}


@end
