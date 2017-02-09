//
//  ViewController.m
//  TextView适配
//
//  Created by Steven on 17/1/20.
//  Copyright © 2017年 Steven. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UITextView+SXTextView.h"
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define SCREEN_WIDE [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITextViewDelegate>
{
    UITextView *_proclaim_title;
    UITextView *_proclaim_author;
    UITextView *_proclaim_content;
    
    UILabel *_line_one;
    UILabel *_line_two;
    UILabel *_line_three;
    
}

@property (nonatomic, strong)UIScrollView *logsSC;

@end

@implementation ViewController

static float height = 34.0f;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    [self setview];
    
    [self rightItem];
    
    //    [self notificationCenterForKeyboard];
}

-(void)rightItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(touchRightItem)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)setview
{
    self.logsSC = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.logsSC.backgroundColor = [UIColor whiteColor];
    self.logsSC.bounces = NO;
    [self.view addSubview:self.logsSC];
    
    
    _proclaim_title = [[UITextView alloc]init];
    _proclaim_title.returnKeyType = UIReturnKeyDone;
    _proclaim_title.delegate = self;
    _proclaim_title.placeholder = @"时间";
    _proclaim_title.textColor = [UIColor cyanColor];
    _proclaim_title.font = [UIFont systemFontOfSize:15];
    _proclaim_title.scrollEnabled = NO;
    [self.logsSC addSubview:_proclaim_title];
    
    _line_one = [[UILabel alloc]init];
    _line_one.backgroundColor = [UIColor brownColor];
    [self.logsSC addSubview:_line_one];
    
   
    _proclaim_author = [[UITextView alloc]init];
    _proclaim_author.returnKeyType = UIReturnKeyDone;
    _proclaim_author.delegate = self;
    _proclaim_author.placeholder = @"地点";
    _proclaim_author.textColor = [UIColor cyanColor];
    _proclaim_author.font = [UIFont systemFontOfSize:15];
    _proclaim_author.scrollEnabled = NO;
    [self.logsSC addSubview:_proclaim_author];
    
    _line_two = [[UILabel alloc]init];
    _line_two.backgroundColor = [UIColor brownColor];
    [self.logsSC addSubview:_line_two];
    
    
    _proclaim_content = [[UITextView alloc]init];
    _proclaim_content.returnKeyType = UIReturnKeyDone;
    _proclaim_content.delegate = self;
    _proclaim_content.placeholder = @"人物";
    _proclaim_content.textColor = [UIColor cyanColor];
    _proclaim_content.font = [UIFont systemFontOfSize:15];
    _proclaim_content.scrollEnabled = NO;
    [self.logsSC addSubview:_proclaim_content];
    
    _line_three = [[UILabel alloc]init];
    _line_three.backgroundColor = [UIColor brownColor];
    [self.logsSC addSubview:_line_three];
    
    
    // 避免block中的循环引用
    
    __block typeof (self) weakSelf = self;
    [_proclaim_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logsSC).offset(64 + 20);
        make.left.equalTo(weakSelf.logsSC).offset(10);
        make.width.equalTo(@(SCREEN_WIDE - 20));
        make.height.equalTo(@(34.0f));
    }];
    
    [_line_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_proclaim_title.mas_bottom).offset(9);
        make.left.equalTo(weakSelf.logsSC);
        make.width.equalTo(@(SCREEN_WIDE));
        make.height.equalTo(@(1));
    }];
    
    [_proclaim_author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line_one.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.logsSC).offset(10);
        make.width.equalTo(@(SCREEN_WIDE - 20));
        make.height.equalTo(@(34.0f));
    }];
    
    [_line_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_proclaim_author.mas_bottom).offset(9);
        make.left.equalTo(weakSelf.logsSC);
        make.width.equalTo(@(SCREEN_WIDE));
        make.height.equalTo(@(1));
    }];
    
    [_proclaim_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line_two.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.logsSC).offset(10);
        make.width.equalTo(@(SCREEN_WIDE - 20));
        make.height.equalTo(@(34.0f));
    }];
    
    [_line_three mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_proclaim_content.mas_bottom).offset(9);
        make.left.equalTo(weakSelf.logsSC);
        make.width.equalTo(@(SCREEN_WIDE));
        make.height.equalTo(@(1));
    }];
    

}
-(void)textViewDidChange:(UITextView *)textView
{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(SCREEN_WIDE - 20 , MAXFLOAT)];
    height = sizeToFit.height;
    
    [textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    
    static CGFloat maxHeight = 280.0f;
    
    if (CGRectGetMaxY(textView.frame) > maxHeight) {
        [UIView animateWithDuration:0.2 animations:^{
            self.logsSC.contentOffset = CGPointMake(0, CGRectGetMaxY(textView.frame) - maxHeight);
        }];
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}
- (void)updateViewFrame:(CGRect)frame WithView:(UIView *)view
{
    NSLog(@"%f",CGRectGetMaxY(frame));
    
    //    [addPhotoView updateConstraints];
    
}
/**
 *  发送公告
 */
-(void)touchRightItem
{
    
}

//当键盘出现或改变时调用
- (void)handleKeyboardDidShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    self.logsSC.frame = CGRectMake(0, 0, SCREEN_WIDE, SCREEN_HEIGHT - height - 70);
}
//当键盘退出时调用
- (void)handleKeyboardDidHidden:(NSNotification *)aNotification
{
    self.logsSC.frame = CGRectMake(0, 0, SCREEN_WIDE , SCREEN_HEIGHT);
}

@end
