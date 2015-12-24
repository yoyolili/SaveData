//
//  OCRawViewController.m
//  数据持久化Demo
//
//  Created by 阿喵 on 15/12/24.
//  Copyright © 2015年 河南青云. All rights reserved.
//

#import "OCRawViewController.h"

#define fileName @"demo.txt"

@interface OCRawViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) NSString *filePath;

@end

@implementation OCRawViewController

- (NSString *)filePath
{
    if (_filePath == nil) {
        
        //1.获取沙盒路径
        NSString *directoryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        
        //2.创建文件夹
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *path = [directoryPath stringByAppendingPathComponent:@"test"];
        
        NSError *error;
        if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:0 error:&error]) {
            
            NSLog(@"error >>> %@",error);
            return nil;
        }
        
        //3.创建文件
        NSString *fpPath = [directoryPath stringByAppendingPathComponent:fileName];//合并文件路径
        if (![fileManager fileExistsAtPath:fpPath]) {
            
            if (![fileManager createFileAtPath:fpPath contents:nil attributes:0]) {//创建文件
                NSLog(@"文件创建失败!");
                return nil;
            }
             _filePath = fpPath;
        }else {
             _filePath = fpPath;
        }
    }
    return _filePath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataFromLocal];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadDataFromLocal
{
    NSString *content = [[NSString alloc]initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    _textField.text = content;
}

- (BOOL)saveData
{
    NSError *error;
    if (![_textField.text writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        NSLog(@"失败!");
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
