//
//  main.m
//  iOSKnowledgePoint
//
//  Created by chenzs on 16/8/22.
//  Copyright © 2016年 chenzhongsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import <sys/mount.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*
         引入头文件  #import <sys/mount.h>
         */
        //iOS 获取手机存储空间的大小
        struct statfs buf;
        long long freespace = 0;
        if (statfs("/", &buf) >= 0) {
            freespace = (long long)buf.f_bsize * buf.f_blocks;
        }
        if (statfs("/private/var", &buf) >= 0) {
            freespace += (long long)buf.f_bsize * buf.f_blocks;
        }
        printf("%f\n",freespace/1024.0/1024.0/1024.0);//g
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
