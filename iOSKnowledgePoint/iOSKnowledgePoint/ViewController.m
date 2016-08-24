//
//  ViewController.m
//  iOSKnowledgePoint
//
//  Created by chenzs on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import "ViewController.h"
// 获取当前设备可用内存及所占内存的头文件
#import <sys/sysctl.h>
#import <mach/mach.h>

#include <sys/param.h>
#include <sys/mount.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat availableMemory = [self availableMemory];
    NSLog(@"availableMemory:%f",availableMemory);
    CGFloat usedMemory = [self usedMemory];
    NSLog(@"usedMemory:%f",usedMemory);
    CGFloat getFreeDiskspace = [ViewController getFreeDiskspace];
    NSLog(@"getFreeDiskspace:%f GB",getFreeDiskspace/1024.0/1024.0/1024.0);//g
    NSString * freeDiskSpaceInBytes = [ViewController freeDiskSpaceInBytes];
    NSLog(@"freeDiskSpaceInBytes:%@ GB",freeDiskSpaceInBytes);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 获取当前设备可用内存(单位：MB）
- (double)availableMemory
{/*
  // 获取当前设备可用内存及所占内存的头文件
  #import <sys/sysctl.h>
  #import <mach/mach.h>
  */
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0 ;
}

// 获取当前任务所占用的内存（单位：MB）
- (double)usedMemory
{/*
  // 获取当前设备可用内存及所占内存的头文件
  #import <sys/sysctl.h>
  #import <mach/mach.h>
  */
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0 ;
}


//手机系统大小、可用空间大小
+(uint64_t)getFreeDiskspace {
    uint64_t totalSpace = 0.0f;
    uint64_t totalFreeSpace = 0.0f;
    NSError *error = nil;
    //获取document目录
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    NSString *destPath = NSHomeDirectory();
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:destPath error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue];
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue];
        //NSLog(@"Memory Capacity of %llu GB with %llu GB Free memory available.", ((totalSpace/1024ll)/1024ll/1024ll), ((totalFreeSpace/1024ll)/1024ll/1024ll));
        NSLog(@"Memory Capacity of %f GB with %f GB Free memory available.", ((totalSpace/1024.0)/1024.0/1024.0), ((totalFreeSpace/1024.0)/1024.0/1024.0));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %d", [error domain], [error code]);
    }
    
    return totalFreeSpace;
}

//获取剩余存储空间函数如下：
+ (NSString *) freeDiskSpaceInBytes{
    /*首先需要引入相关的头文件，引入头文件代码如下：
     #include <sys/param.h>
     #include <sys/mount.h>
     */
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
    }
    return [NSString stringWithFormat:@"手机剩余存储空间为：%qi GB" ,freespace/1024/1024/1024];
}



//iOS开发 - 如何获取设备的总容量和可用容量 (2014-05-21 13:57:25)转载▼
//标签： ios设备 可用容量 总容量 清除沙盒缓存 it	分类： 技术分享
//清除沙盒缓存时，需要显示设备的总容量和可用容量。先研究如下（返回为byte单位）：
+ (NSNumber *)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}
+ (NSNumber *)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

@end
