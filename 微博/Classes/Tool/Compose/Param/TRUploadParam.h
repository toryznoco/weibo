//
//  TRUploadParam.h
//  微博
//
//  Created by Tory on 15/11/15.
//  Copyright © 2015年 normcore. All rights reserved.
//  图片上传的参数模型

#import <Foundation/Foundation.h>

@interface TRUploadParam : NSObject
/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
