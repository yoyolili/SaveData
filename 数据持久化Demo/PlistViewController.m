//
//  PlistViewController.m
//  数据持久化Demo
//
//  Created by 阿喵 on 15/12/24.
//  Copyright © 2015年 河南青云. All rights reserved.
//

#import "PlistViewController.h"

#define fileName @"testPlist.plist"

@interface PlistViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitch;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (nonatomic ,strong) NSString *filePath;
@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataFromLocal];
    // Do any additional setup after loading the view from its nib.
}

- (NSString *)filePath
{
    if (_filePath == nil) {
        
        //获取library路径
        NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        
        //创建文件夹
        NSString *directoryPath = [libraryPath stringByAppendingPathComponent:@"Plist"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSError *error;
        if (![fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:0 error:&error]) {
            NSLog(@"error >>> %@",error);
            return nil;
        }
        
        NSString *fpPath = [directoryPath stringByAppendingPathComponent:fileName];
        //判断文件是否存在
        if (![fileManager fileExistsAtPath:fpPath]) {
            if (![fileManager createFileAtPath:fpPath contents:nil attributes:0]) {
                NSLog(@"文件创建失败!");
                return nil;
            }
            _filePath = fpPath;
        }else{
            _filePath = fpPath;
        }
    }
    return _filePath;
}

- (void)loadDataFromLocal
{
    //读取plist文件
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:self.filePath];
    _sexSwitch.on = [dict[@"sex"] boolValue];
    _nameText.text = dict[@"name"];
    _ageText.text = [dict[@"age"] stringValue];
    _slider.value = [dict[@"volumn"] floatValue];
    
}

- (BOOL)saveData
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(_sexSwitch.on) forKey:@"sex"];
    [dict setObject:_nameText.text forKey:@"name"];
    [dict setObject:@(_ageText.text.integerValue) forKey:@"age"];
    [dict setObject:@(_slider.value) forKey:@"volumn"];
    
    //将dict写入Plist文件
    if (![dict writeToFile:self.filePath atomically:YES]) {
        NSLog(@"写入失败!");
        return NO;
    }
    return YES;
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
