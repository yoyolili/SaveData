//
//  CRAWViewController.m
//  数据持久化Demo
//
//  Created by 阿喵 on 15/12/24.
//  Copyright © 2015年 河南青云. All rights reserved.
//

#import "CRAWViewController.h"

#define fileName @"test.txt"

@interface CRAWViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation CRAWViewController

- (NSString *)filePath
{
    if (_filePath == nil) {
        //获取沙盒路径
        NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        _filePath = [libraryPath stringByAppendingPathComponent:fileName];
    }
    
    return _filePath;
}

- (void)loadDataFromLocal
{
    FILE *fp;
    fp = fopen([self.filePath UTF8String], "r");
    if (fp == NULL) {
        NSLog(@"打开文件失败!");
        return;
    }
    
    //读取磁盘上的数据-->内存
    char buffer[1024] = {0};//声明一个容器
    fseek(fp, 0, SEEK_END);//计算读取的文件长度
    long len = ftell(fp);//文件长度，必须在fseek调用之后才能使用，才能计算文件长度
    
    //将文件指针指向开始位置
    rewind(fp);
    
    //读操作
    size_t count = fread(buffer, len, 1, fp);
    if (count > 0) {
        NSLog(@"读取成功!");
    }
    
    fclose(fp);
    
    //将内容赋给textField
    _textField.text = [NSString stringWithUTF8String:buffer];
    
}
- (BOOL)saveData
{
    //定义指针
    FILE *fp;
    //打开文件
    fp = fopen([self.filePath UTF8String], "w+");
    if (fp == NULL) {
        NSLog(@"打开文件失败!");
        return NO;
    }
    
    NSString *content = _textField.text;
    int length = (int)content.length;
    
    //写入操作
    size_t count = fwrite([content UTF8String], length, 1, fp);
    if (count > 0) {
        NSLog(@"写入成功");
    }
    
    //关闭文件
    fclose(fp);
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataFromLocal];
    
    NSLog(@"filePath >>> %@",self.filePath);
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)touchSave:(UIButton *)sender {
    
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
