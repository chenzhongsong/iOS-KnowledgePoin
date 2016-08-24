//
//  ZSTools.m
//  iOSKnowledgePoint
//
//  Created by chenzs on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "ZSTools.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/**
 *  iOS开发零碎知识点整理 摘自HYB
 */
@implementation ZSTools

#pragma mark - 调用代码使APP进入后台
/**
 *  调用代码使APP进入后台  suspend的英文意思有：暂停; 悬; 挂; 延缓;
 */
+ (void)suspendBackground {
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
}

#pragma mark - 带中文的URL处理
/**
 *  带中文的URL处理
 */
+ (void)handleChineseURL {
    
    NSString *chineseUrl = @"http://static.tripbe.com/videofiles/视频/我的自拍视频.mp4";
    NSString *path  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,                                                                                                             (__bridge CFStringRef)chineseUrl,                                                                                                        CFSTR(""),                                                                                                                CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)); //chineseUrl replace of model.mp4_url
    
}


#pragma mark - 取WebView高度
/**
 *  取WebView高度  个人最常用的获取方法，感觉这个比较靠谱：
 */
+ (void)obtainWebViewHeight {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView  {
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGRect frame = webView.frame;
    webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
}

#pragma mark - View设置图片
/**
 *  View设置图片
 */
+ (void)settingViewImage {
//    第一种方法
//    利用的UIView的设置背景颜色方法，用图片做图案颜色，然后传给背景颜色。

    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"bgImg.png"]];
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    [myView setBackgroundColor:bgColor];
    
    //第二种方法
    UIView *yourView = [UIView new];
    UIImage *image = [UIImage imageNamed:@"yourPicName@2x.png"];
    yourView.layer.contents = (__bridge id)image.CGImage;
    // 设置显示的图片范围
    yourView.layer.contentsCenter = CGRectMake(0.25,0.25,0.5,0.5);//四个值在0-1之间，对应的为x，y，width，height。
    
}


#pragma mark - 去TableView分割线
/**
 *  去TableView分割线
 */
+ (void)clearTableFooterViewLine {
    UITableView *yourTableView = [UITableView new];
    yourTableView.tableFooterView = [UIView new];
}


#pragma mark - 调cell分割线位置
/**
 *  调cell分割线位置
 */
- (void)viewDidLayoutSubviews {
    UITableView *mytableview = [UITableView new];
    if ([mytableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [mytableview setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        
    }
    if ([mytableview respondsToSelector:@selector(setLayoutMargins:)])  {
        [mytableview setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

#pragma mark - cell分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}


#pragma mark - Label注意事项
/**
 *  七、Label注意事项
 UILabel和UIImageView的交互userInteractionEabled默认为NO。那么如果你把这两个类做为父试图的话，里面的所有东东都不可以点击哦。
 
 曾经有一个人，让我帮忙调试bug，他调试很久没搞定，就是把WMPlayer对象（播放器对象）放到一个UIImageView上面。这样imageView addSubView:wmPlayer 后，播放器的任何东东都不能点击了。userInteractionEabled设置为YES即可。
 */


#pragma mark - 搜索条Cancel改标题
/**
 *  搜索条Cancel改标题
 */
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    UISearchController *searchController = [[UISearchController alloc] init];
    
    searchController.searchBar.showsCancelButton = YES;
    UIButton *canceLBtn = [searchController.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:[UIColor colorWithRed:14.0/255.0 green:180.0/255.0 blue:0.0/255.0 alpha:1.00] forState:UIControlStateNormal];
    searchBar.showsCancelButton = YES;
    return YES;
}

#pragma mark - TableView收键盘
/**
 *  TableView收键盘。
    一个属性搞定，效果好（UIScrollView同样可以使用） 以前是不是觉得[self.view endEditing:YES];很屌，这个下面的更屌。
 
    yourTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
 
    另外一个枚举为UIScrollViewKeyboardDismissModeInteractive，表示在键盘内部滑动，键盘逐渐下去。
 */

#pragma mark - NSTimer
/**
 *  NSTimer计算的时间并不精确
    NSTimer需要添加到runLoop运行才会执行，但是这个runLoop的线程必须是已经开启。
    NSTimer会对它的tagert进行retain，我们必须对其重复性的使用intvailte停止。target如果是self（指UIViewController），那么VC的retainCount+1，如果你不释放NSTimer，那么你的VC就不会dealloc了，内存泄漏了。
 */

#pragma mark - 控制器没大小
/**
 *  控制器没大小
    经常有人在群里问：怎么改变VC的大小啊？ 瞬间无语。（只有UIView才能设置大小，VC是控制器啊，哥！）
 */


#pragma mark - 十六进制取颜色
/**
 *  十六进制取颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


#pragma mark - 获取今天是星期几
/**
 *  获取今天是星期几
 */
+ (NSString *) getweekDayStringWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString = @"(周一)";
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"(周日)";
        }
            break;
            
        case 2:
        {
            weekDayString = @"(周一)";
        }
            break;
            
        case 3:
        {
            weekDayString = @"(周二)";
        }
            break;
            
        case 4:
        {
            weekDayString = @"(周三)";
        }
            break;
            
        case 5:
        {
            weekDayString = @"(周四)";
        }
            break;
            
        case 6:
        {
            weekDayString = @"(周五)";
        }
            break;
            
        case 7:
        {
            weekDayString = @"(周六)";
        }
            break;
            
        default:
            break;
    }
    return weekDayString;
}

#pragma mark - UIView的部分圆角问题
/**
 *  UIView的部分圆角问题
 */
+ (void)viewOf圆角 {
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(120, 10, 80, 80)];
    view2.backgroundColor = [UIColor redColor];
    //[self.view addSubview:view2];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view2.bounds;
    maskLayer.path = maskPath.CGPath;
    view2.layer.mask = maskLayer;
    //其中，byRoundingCorners:UIRectCornerBottomLeft |UIRectCornerBottomRight
    //指定了需要成为圆角的角。该参数是UIRectCorner类型的，可选的值有：
    //    * UIRectCornerTopLeft
    //    * UIRectCornerTopRight
    //    * UIRectCornerBottomLeft
    //    * UIRectCornerBottomRight
    //    * UIRectCornerAllCorners
    
    //从名字很容易看出来代表的意思，使用“|”来组合就好了。
}

#pragma mark - 滑动时隐藏navigationBar
/**
 *  滑动时隐藏navigationBar
 */
+ (void)hiddenNavigationBarWhenScroller {
    //self.navigationController.hidesBarsOnSwipe = Yes;
}


#pragma mark - iOS画虚线
/**
 *  iOS画虚线  记得先 QuartzCore框架的导入  #import <QuartzCore/QuartzCore.h>
 */
+ (void)Thedottedline {
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 10.0, 20.0);
    CGContextAddLineToPoint(context, 310.0,20.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}


#pragma mark - 自动布局多行UILabel问题
/**
 *  自动布局多行UILabel问题  
 
    需要设置其preferredMaxLayoutWidth属性才能正常显示多行内容。另外如果出现显示不全文本，可以在计算的结果基础上＋0.5。
 */
+ (void)heightForLabel {
    //attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]}
    //CGFloat h = [model.message boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - kGAP-kAvatar_Size - 2*kGAP, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height+0.5;
    //通常使用NSStringDrawingUsesLineFragmentOrigin，如果options参数为NSStringDrawingUsesLineFragmentOrigin，那么整个文本将以每行组成的矩形为单位计算整个文本的尺寸。
}


#pragma mark - 禁止运行时自动锁屏
/**
 *  禁止运行时自动锁屏
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
 */


#pragma mark - KVC相关
/**
 *  KVC相关
    
 KVC同时还提供了很复杂的函数，主要有下面这些
 
 ①简单集合运算符
 简单集合运算符共有@avg， @count ， @max ， @min ，@sum5种，都表示啥不用我说了吧， 目前还不支持自定义。
 
 @interface Book : NSObject
 @property (nonatomic,copy)  NSString* name;
 @property (nonatomic,assign)  CGFloat price;
 @end
 
 @implementation Book
 
 @end
 
 Book *book1 = [Book new];
 book1.name = @"The Great Gastby";
 book1.price = 22;
 Book *book2 = [Book new];
 book2.name = @"Time History";
 book2.price = 12;
 Book *book3 = [Book new];
 book3.name = @"Wrong Hole";
 book3.price = 111;
 
 Book *book4 = [Book new];
 book4.name = @"Wrong Hole";
 book4.price = 111;
 
 NSArray* arrBooks = @[book1,book2,book3,book4];
 NSNumber* sum = [arrBooks valueForKeyPath:@"@sum.price"];
 NSLog(@"sum:%f",sum.floatValue);
 NSNumber* avg = [arrBooks valueForKeyPath:@"@avg.price"];
 NSLog(@"avg:%f",avg.floatValue);
 NSNumber* count = [arrBooks valueForKeyPath:@"@count"];
 NSLog(@"count:%f",count.floatValue);
 NSNumber* min = [arrBooks valueForKeyPath:@"@min.price"];
 NSLog(@"min:%f",min.floatValue);
 NSNumber* max = [arrBooks valueForKeyPath:@"@max.price"];
 NSLog(@"max:%f",max.floatValue);
 
 打印结果
 
 2016-04-20 16:45:54.696 KVCDemo[1484:127089] sum:256.000000
 2016-04-20 16:45:54.697 KVCDemo[1484:127089] avg:64.000000
 2016-04-20 16:45:54.697 KVCDemo[1484:127089] count:4.000000
 2016-04-20 16:45:54.697 KVCDemo[1484:127089] min:12.000000
 NSArray 快速求总和 最大值 最小值 和 平均值
 
 例2
 
 NSArray *array = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", @"10", nil];
 CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
 CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
 CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
 CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
 NSLog(@"%f\n%f\n%f\n%f",sum,avg,max,min);
 */


#pragma mark - 用MBProgressHud问题
/**
 *  用MBProgressHud问题
    
    尽量不要加到UIWindow上，加self.view上即可。如果加UIWindow上在iPad上，旋转屏幕的时候MBProgressHud不会旋转。之前有人遇到这个bug，我让他改放到self.view上即可解决此bug。
 */


#pragma mark - 强制App直接退出
/**
 *  强制App直接退出
 */
- (void)exitApplication {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}


#pragma mark - Label行间距
/**
 *  Label行间距
 */
+ (void)rowSpacingOfLabel {
    
    UILabel *contentLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [contentLabel.text length])];
    contentLabel.attributedText = attributedString;
    
}


#pragma mark - pod更新慢的问题
/**
 *  pod更新慢的问题
 
 pod install –verbose –no-repo-update
 pod update –verbose –no-repo-update
 
 如果不加后面的参数，默认会升级CocoaPods的spec仓库，加一个参数可以省略这一步，然后速度就会提升不少。
 */


#pragma mark - MRC和ARC混编设置方式
/**
 *  MRC和ARC混编设置方式
 
 在XCode中targets的build phases选项下Compile Sources下选择->不需要arc编译的文件，双击输入 -fno-objc-arc 即可
 
 MRC工程中也可以使用ARC的类，方法如下：
 
 在XCode中targets的build phases选项下Compile Sources下选择要使用arc编译的文件，双击输入 -fobjc-arc 即可
 
 */


#pragma mark - cell对勾颜色修改
/**
 *  cell对勾颜色修改
 
    _yourTableView.tintColor = [UIColor redColor];
 */


#pragma mark - 同时按两个按钮问题
/**
 *  同时按两个按钮问题
 
    [button setExclusiveTouch:YES];
 */


#pragma mark - 修改占位符颜色和大小
/**
 *  修改占位符颜色和大小
 
 textField.placeholder = @"请输入用户名";
 [textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
 [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
 
 */


#pragma mark - 禁止复制粘贴
/**
 *  禁止复制粘贴
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if ([UIMenuController sharedMenuController]) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}


#pragma mark - 进入App在AppStore页面
/**
 *  进入App在AppStore页面
 
 先用iTunes Link Maker找到软件在访问地址，格式为itms-apps://ax.itunes.apple.com/…，然后复制链接！
 
 #define  ITUNESLINK   @"itms-apps://ax.itunes.apple.com/..."
 NSURL *url = [NSURL URLWithString:ITUNESLINK];
     if([[UIApplication sharedApplication] canOpenURL:url]){
     [[UIApplication sharedApplication] openURL:url];
 }
 
 如果把上述地址中itms-apps改为http就可以在浏览器中打开了。可以把这个地址放在自己的网站里，链接到app store。 iTunes Link Maker地址：http://itunes.apple.com/linkmaker
 */


#pragma mark - 隐藏系统tabbar
/**
 *  隐藏系统tabbar
 
 
 二级、三级界面隐藏系统tabbar方法.
 
 1、单个处理
 
 YourViewController *yourVC = [YourViewController new];
 yourVC.hidesBottomBarWhenPushed = YES;
 [self.navigationController pushViewController:yourVC animated:YES];
 
 
 2.统一在基类里面处理
 
 新建一个类BaseNavigationController继承UINavigationController，然后重写 -(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated这个方法。所有的push事件都走此方法。
 
 @interface BaseNavigationController : UINavigationController
 
 @end
 
 -(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count>1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
 }
 
 */


#pragma mark - 取消系统的返回手势
/**
 *  取消系统的返回手势  一行代码搞定：
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
 */


#pragma mark - 改WebView字体/颜色
/**
 *  改WebView字体/颜色
 
    UIWebView设置字体大小，颜色，字体： UIWebView无法通过自身的属性设置字体的一些属性，只能通过html代码进行设置 在webView加载完毕后：
 */
- (void)webViewDidFinishLoad_:(UIWebView *)webView {
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'";
    [webView stringByEvaluatingJavaScriptFromString:str];

    //或者加入以下代码
    //    NSString *jsString = [[NSString alloc]
    //    initWithFormat:@"document.body.style.fontSize=%f;document.body.style.color=%@",fontSize,fontColor];
    //    [webView stringByEvaluatingJavaScriptFromString:jsString];
}
@end











































