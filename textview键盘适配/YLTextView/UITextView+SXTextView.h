//
//  Created by Steven on 16/9/9.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SXTextView)

/* 占位符 */
@property (nonatomic,strong) NSString *placeholder;
//@property (copy, nonatomic) NSNumber *limitLength;//限制字数

/* 设置文本 */
- (NSString *)sx_setText:(NSString *)text;

@end
