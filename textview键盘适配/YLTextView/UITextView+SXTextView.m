
//
//
//  Created by Steven on 16/9/9.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "UITextView+SXTextView.h"
#import <objc/runtime.h>
@interface UITextView ()
/* 占位符 */
@property (nonatomic,strong) UILabel *placeholderLabel;
//@property (nonatomic,strong) UILabel *wordCountLabel;//计算字数
@end
@implementation UITextView (SXTextView)

/*******************Runtime 运行时*****************************/

/* 以下为运行时需要添加关联的关键字 */
static NSString *PLACEHOLDLABEL = @"placelabel";
static NSString *PLACEHOLD = @"placehold";
static NSString *WORDCOUNTLABEL = @"wordcount";
static const void *limitLengthKey = &limitLengthKey;

+ (void)load {
    
    /***方法交换,避免初始text直接赋值导致place同时存在的情况***/
    
    /*获取类方法*/
    Method setText = class_getInstanceMethod([UITextView class], @selector(setText:));
    /*获取实例方法*/
    Method sx_setText = class_getInstanceMethod([UITextView class], @selector(sx_setText:));
    method_exchangeImplementations(setText, sx_setText);
    
    

    
    
}
- (NSString *)sx_setText:(NSString *)text {
    
    UITextView *sx_text = self;
    [sx_text sx_setText:text];
    if (text.length > 0) {
        self.placeholderLabel.hidden = YES;
    }
    return sx_text.text;
}

#pragma mark -- 运行时get/set 操作

-(void)setPlaceholderLabel:(UILabel *)placeholderLabel {

    /* 添加UILabel属性 */
    objc_setAssociatedObject(self, &PLACEHOLDLABEL, placeholderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeholderLabel {
    /* 根据关联对象取出属性 */
    return objc_getAssociatedObject(self, &PLACEHOLDLABEL);

}

- (void)setPlaceholder:(NSString *)placeholder {
    
    /* 添加字符串Placeholder属性 */
    objc_setAssociatedObject(self, &PLACEHOLD, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setPlaceHolderLabel:placeholder];
}

- (NSString *)placeholder {

    return objc_getAssociatedObject(self, &PLACEHOLD);
}


- (UILabel *)wordCountLabel {

    return objc_getAssociatedObject(self, &WORDCOUNTLABEL);

}
- (void)setWordCountLabel:(UILabel *)wordCountLabel {

    objc_setAssociatedObject(self, &WORDCOUNTLABEL, wordCountLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}


- (NSNumber *)limitLength {

    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)setLimitLength:(NSNumber *)limitLength {
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addLimitLengthObserver:[limitLength intValue]];

    [self setWordcountLable:limitLength];
    
}

#pragma mark -- 配置占位符标签

- (void)setPlaceHolderLabel:(NSString *)placeholder {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self];
    /*
     *  占位字符
     */
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = [UIFont systemFontOfSize:15.f];
    self.placeholderLabel.text = placeholder;
    self.placeholderLabel.numberOfLines = 0;
    self.placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    CGRect rect = [placeholder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-7, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.]} context:nil];
    self.placeholderLabel.frame = CGRectMake(7, 7, rect.size.width, rect.size.height);
    [self addSubview:self.placeholderLabel];

}

#pragma mark -- 配置字数限制标签

- (void)setWordcountLable:(NSNumber *)limitLength {
    
    /*
     *  字数限制
     */
    self.wordCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 65, CGRectGetHeight(self.frame) - 20, 60, 20)];
    self.wordCountLabel.textAlignment = NSTextAlignmentRight;
    self.wordCountLabel.textColor = [UIColor lightGrayColor];
    self.wordCountLabel.font = [UIFont systemFontOfSize:13.];
    self.wordCountLabel.text = [NSString stringWithFormat:@"0/%@",limitLength];
    [self addSubview:self.wordCountLabel];
}


#pragma mark -- 增加限制位数的通知
- (void)addLimitLengthObserver:(int)length {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limitLengthEvent) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 限制输入的位数
- (void)limitLengthEvent {

    if ([self.text length] > [self.limitLength intValue]) {

        self.text = [self.text substringToIndex:[self.limitLength intValue]];
    }
}


#pragma mark -- NSNotification

- (void)textFieldChanged:(NSNotification *)notification {
    if (self.placeholder) {
        self.placeholderLabel.hidden = YES;
        
        if (self.text.length == 0) {
            
            self.placeholderLabel.hidden = NO;
        }
    }
    if (self.limitLength) {
        
        NSInteger wordCount = self.text.length;
        if (wordCount > [self.limitLength integerValue]) {
            wordCount = [self.limitLength integerValue];
        }
        self.wordCountLabel.text = [NSString stringWithFormat:@"%ld/%@",wordCount,self.limitLength];
        
    }

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];

}


@end
