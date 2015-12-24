//
//  NSUserViewController.m
//  数据持久化Demo
//
//  Created by 阿喵 on 15/12/24.
//  Copyright © 2015年 河南青云. All rights reserved.
//

/*
 *可以使用NSUserDefaults保存一些基本设置信息，默认生成的plist文件保存在library目录下,文件名为bundleID
 */

#import "NSUserViewController.h"

@interface NSUserViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitch;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation NSUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadData];
}

- (BOOL)saveData
{
    //1.获取NSUserDefaults 对象
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    
    //2.设置值
    [users setBool:_sexSwitch.on forKey:@"sex"];
    [users setInteger:_ageText.text.integerValue forKey:@"age"];
    [users setObject:_nameText.text forKey:@"name"];
    [users setFloat:_slider.value forKey:@"volumn"];
    
    //3.同步->plist文件
    [users synchronize];

    return YES;
}
- (void)loadData
{
    //1.从plist中取出数据
    NSUserDefaults *users = [NSUserDefaults standardUserDefaults];
    
    //2.更新UI
    _sexSwitch.on = [users boolForKey:@"sex"];
    _ageText.text = [NSString stringWithFormat:@"%ld",(long)[users integerForKey:@"age"]];
    _nameText.text = [users objectForKey:@"name"];
    _slider.value = [users floatForKey:@"volumn"];

}
- (IBAction)touchSave:(id)sender {

    [self saveData];
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
