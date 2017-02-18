//
//  AnotherController.m
//  UITextField限制字数Demo
//
//  Created by DFD on 2017/2/18.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "AnotherController.h"
#import "DFTextField.h"

@interface AnotherController ()
@property (weak, nonatomic) IBOutlet DFTextField *textField;

@end

@implementation AnotherController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.maxLengh = 5;
    
    DFTextField *textField1 = [[DFTextField alloc] initWithFrame:CGRectMake(10, 110, 100, 30)];
    textField1.borderStyle = UITextBorderStyleRoundedRect;
    textField1.maxLengh = 6;
    [self.view addSubview:textField1];
    
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
