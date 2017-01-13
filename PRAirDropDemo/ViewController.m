//
//  ViewController.m
//  PRAirDropDemo
//
//  Created by pengrun on 2017/1/12.
//  Copyright © 2017年 pengrun. All rights reserved.
//

#import "ViewController.h"
#import "PRAirDropData.h"

#define kGetFileUrl @"kGetFileUrl"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSInteger flag;
}
@property (nonatomic, strong) NSString *fileUrl;
@property (strong, nonatomic) UIPopoverController *activityPopover;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFileUrl:) name:kGetFileUrl object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)getFileUrl:(NSNotification *)notification {
    NSString *path = notification.object;
    
    NSString* content = [NSString stringWithContentsOfFile:notification.object encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"NSString类方法读取的内容是：\n%@",content);
//    if ([path containsString:@"file://"]) {
//        [path deleteCharactersInRange:NSMakeRange(0, 7)];
//    }
    
    [self.dataArray insertObject:path atIndex:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    flag ++;
}
- (void)showFiles:(NSString *)path{
    // 1.判断文件还是目录
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        // 2. 判断是不是目录
        if (isDir) {
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:path error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [path stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                [self showFiles:subPath];
            }
            
            
        } else {
            [self.dataArray addObject:path];
        }
    } else {
        NSLog(@"你打印的是目录或者不存在");
    }
}
- (IBAction)load:(id)sender {
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* thepath = [paths firstObject];
    [self.dataArray removeAllObjects];
    [self showFiles:thepath];
    [self.tableView reloadData];
}

- (IBAction)share:(id)sender {
    UIView *sender1 = sender;
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"blog1" ofType:@"prdata"];
    NSURL *url1 = [NSURL fileURLWithPath:path1];
    PRAirDropData *item1 = [[PRAirDropData alloc] initWithURL:url1 subject:@"blog1"];
    
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"blog2" ofType:@"prdata"];
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    PRAirDropData *item2 = [[PRAirDropData alloc] initWithURL:url2 subject:@"blog2"];
    
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"blog3" ofType:@"prdata"];
    NSURL *url3 = [NSURL fileURLWithPath:path3];
    PRAirDropData *item3 = [[PRAirDropData alloc] initWithURL:url3 subject:@"blog3"];
    
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"blog4" ofType:@"prdata"];
    NSURL *url4 = [NSURL fileURLWithPath:path4];
    PRAirDropData *item4 = [[PRAirDropData alloc] initWithURL:url4 subject:@"blog4"];
    
    
    
    NSArray *items = [NSArray arrayWithObjects:item1,item2,item3,item4, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    
    // Exclude all activities except AirDrop.
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter,
                                    UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage,
                                    UIActivityTypeMail,
                                    UIActivityTypePrint,
                                    UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact,
                                    UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList,
                                    UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo,
                                    UIActivityTypePostToTencentWeibo];
    activityViewController.excludedActivityTypes = excludedActivities;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
    else {
        if (![self.activityPopover isPopoverVisible]) {
            self.activityPopover = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
            [self.activityPopover presentPopoverFromRect:[sender1 frame]
                                                  inView:self.view
                                permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else {
            [self.activityPopover dismissPopoverAnimated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSFileManager* fm = [NSFileManager defaultManager];
    NSData* data = [[NSData alloc] init];
    data = [fm contentsAtPath:self.dataArray[indexPath.row]];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    cell.textLabel.text = str;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
