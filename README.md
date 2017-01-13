# PRAirDropDemo
通过airDrop接收、发送非官方文件，在airDrop菜单中加入三方app（同理邮箱附件打开方式中的三方app）

### 前言

朋友通过airDrop给我传图片时，接受后，自动保存在相册中了。但是当朋友通过airDrop给我发非图片非视频时，会提示"AirDrop打开方式…"，如下图：<!--more-->

![](http://ww4.sinaimg.cn/large/006tNbRwgw1fbnsfphsnuj30k00zk0u4.jpg)

那么如何让自己的app能够显示在菜单中？那么现在一步一来操作。

### 流程

从我自己的了解程度，总结以下流程，如果有问题，还待大家吐槽。

1. airdrop传输最初的接收者是ios系统本身，而非任何app；
2. - 当接收的文件是ios系统默认能够打开的（如.mp4、.jpeg、.tiff、iwork一套等是苹果默认能够打开的），在同意接收后，会自动保存在对应的目录下；
   - 当接收的文件不是ios系统默认能够打开的，那么同意接受后，会弹出选择打开方式（即选择三方app）的菜单列表（下面称菜单）；
3. 三方app需要在系统中授权之后才能被加入到菜单；
4. 以三方app打开之后，这时候app才算是接收者，就要在三方app中，用专用接口去把接收到的文件移动到本地app中文件目录下。
5. 此时才能正常读取接受到的文件。

注：此过程没接收那么当然不会保存在系统中来，但是如果你一旦用三方app打开之后，系统中接收到的文件移动到三方app中，那么系统中文件被删除了，如果你接受了，没有选择三方app，那么系统会自动清除此文件。

### 理论

#### 添加文档类型

要添加文档类型，请执行以下操作：

1. 在您的Xcode项目中，选择要添加文档类型的目标。

2. 选择信息选项卡。

3. 单击文档类型的公开按钮以打开文档类型。

4. 点击“+”按钮。

5. 在新创建的文档类型中：

6. ​

   - 键入文档类型的名称。
   - 在“类型”部分填写新类型的UTI。
   - 提供文档的图标。

   ​

7. 单击公开三角形以打开其他文档类型属性。

8. 单击表中以添加新的键和值。

9. ​

   - 对于键值类型：CFBundleTypeRole。
   - 对于值类型：编辑器。

   ​

10. 单击+按钮添加另一个键/值对。

11. ​

    - 对于键值类型：LSHandlerRank。
    - 对于值类型：Owner。

#### 添加自定义UTI

如果要添加的文档类型是自定义文档类型或iOS不知道的文档类型，则需要为文档类型定义UTI。要添加新的UTI，请执行以下操作：

1. 在您的Xcode项目中，选择要添加新UTI的目标。

2. 选择信息选项卡。

3. 单击导出的UTI的公开按钮。

4. 点击“+”按钮。

5. 选择“添加导出的UTI”。

6. ​

   - 在描述字段中，填写UTI的描述。
   - 在标识符字段中，填写UTI的标识符。
   - 在Conforms To字段中填写此新UTI符合的UTI列表。

   ​

7. 切换“其他导出的UTI属性”公开三角形以打开一个表，您可以在其中添加一些其他信息。

8. 单击空表，将显示可添加到表中的项目列表。

9. 键入“UTTypeTagSpecification”。

10. 将类型设置为字典。

11. 单击显示三角形将其打开，然后单击表行中的+按钮添加条目。

12. 对于“新项目”，将名称更改为“public.filename-extension”。

13. 对于项目的类型，将其更改为“Array”。

14. 切换打开刚刚添加的项，然后点击表格行中的+按钮。

15. 对于项0，将“值”更改为文档的文件扩展名。例如，txt，pdf，docx等

### 实战

#### 把app加入菜单中

##### 创建新项目

此处省略XXX字

##### 添加文档类型

1. **增加类型**

   进入新项目的`TARGETS`--`Info`中`Document Types`点击`+`然后输入`Name`和`Types`，注意：`Types`最好输入`Bundle Identifier`。![](http://ww1.sinaimg.cn/large/006tNc79gw1fbnth7gwfkj30k40g0taz.jpg)

2. 增加**Additional document type properties** 

   点击 `Additional document type properties`之前的倒三角，然后点击展开后的空白区域会出现key-value键值对，然后输入`CFBundleTypeRole : Editor `和`LSHandlerRank :Owner`两组键值对。![](http://ww3.sinaimg.cn/large/006tNc79gw1fbnthnal0hj30mu09ujsc.jpg)

3. 增加**Exported UTIs**

   点击 `Exported UTIs`之前的倒三角，填写`Description`、`Identifier`、`Conforms To`信息![](http://ww2.sinaimg.cn/large/006tNc79gw1fbntkdz4brj30mg0dh0u5.jpg)

4. 点击 `Additional exported UTI properties`之前的倒三角，然后点击展开后的空白区域会出现key-value键值对，

   ```objective-c
   {
       "UTTypeTagSpecification": {
           "public.filename-extension": [
               {
                   "item 0": "prdata",
                   "url": "http://www.google.com"
               }
           ]
       }
   }
   ```

   ![](http://ww4.sinaimg.cn/large/006tNc79gw1fbntlu1a43j30mv0g7q4n.jpg)

##### 效果

通过airDrop发送`.prdata`为后缀的文件，接收手机就能展示出来app名字了。![](http://ww1.sinaimg.cn/large/006tNc79gw1fbnukeghxcj30k00zkdhy.jpg)

##### 场景

除了上面的场景菜单中加入了三方app，还适合通过airDrop以三方app打开(如打开邮件中的附件)

#### 读取文件信息

在appdelegate里面加入

```objective-c
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0); // no equiv. notification. return NO if the application can't open for some reason
```

方法，处理系统传过来的URL，然后进行数据处理，代码如下

```objective-c
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    if ([url isFileURL] && [[[url absoluteString] pathExtension] isEqualToString:@"prdata"]) {
        [self copyItemAtURLtoDocumentsDirectory:url];
        return YES;
    }
    return NO;
}

//把接受到的文件移动到本地app文件目录下面
- (BOOL)copyItemAtURLtoDocumentsDirectory:(NSURL *)url
{
    NSError *error;
    NSURL *copyToURL = [self applicationDocumentsDirectory];
    NSString *fileName = [url lastPathComponent];
    
    copyToURL = [copyToURL URLByAppendingPathComponent:fileName isDirectory:NO];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:copyToURL.path]) {
        
        NSURL *duplicateURL = copyToURL;
        copyToURL = [copyToURL URLByDeletingPathExtension];
        NSString *fileNameWithoutExtension = [copyToURL lastPathComponent]; //没有后缀的文件名
        NSString *fileExtension = [url pathExtension]; //文件后缀
        
        int i = 1;
        while ([[NSFileManager defaultManager] fileExistsAtPath:duplicateURL.path]) {  //判断是否存在，存在就重新命名
            copyToURL = [copyToURL URLByDeletingLastPathComponent];
            copyToURL = [copyToURL URLByAppendingPathComponent:[NSString stringWithFormat:@"%@–%i", fileNameWithoutExtension, i]];
            copyToURL = [copyToURL URLByAppendingPathExtension:fileExtension];
            duplicateURL = copyToURL;
            i++;
        }
    }
    
    BOOL ok = [[NSFileManager defaultManager] moveItemAtURL:url toURL:copyToURL error:&error]; //把系统传过来的url对应的文件 移动到 本地app中
    if (!ok) {
        NSLog(@"%@", [error localizedDescription]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kGetFileUrl" object:copyToURL.path];
    return ok;
}

- (NSURL *)applicationDocumentsDirectory
{
    NSString *documentsDirectory;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0) {
        documentsDirectory = [paths objectAtIndex:0];
    }
    return [NSURL fileURLWithPath:documentsDirectory];
}
```

#### 发送文件

在VC里面加入`UIPopoverController`代码如下：

```objective-c
NSString *path1 = [[NSBundle mainBundle] pathForResource:@"blog" ofType:@"prdata"];
    NSURL *url1 = [NSURL fileURLWithPath:path1];
    PRAirDropData *item1 = [[PRAirDropData alloc] initWithURL:url1 subject:@"blog"];
    
    NSArray *items = [NSArray arrayWithObjects:item1, nil];
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
```

### 博客

如果需要源码的请点击点击[[Blog](http://www.mrpeng.me)