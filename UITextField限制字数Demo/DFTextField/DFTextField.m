//
//  DFTextField.m
//  UITextField限制字数Demo
//
//  Created by DFD on 2017/2/17.
//  Copyright © 2017年 DFD. All rights reserved.
//

#import "DFTextField.h"


@interface DFTextField(){
    NSUInteger MAX_STARWORDS_LENGTH;
}



@end


@implementation DFTextField


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addObserver];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addObserver];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setMaxLengh:(NSUInteger)maxLengh{
    _maxLengh = maxLengh;
    MAX_STARWORDS_LENGTH = maxLengh;
}

- (void)addObserver{
    MAX_STARWORDS_LENGTH = 20;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldEditChanged:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:self];
}

#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]){// 简体中文输入
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position){
            if (toBeString.length > MAX_STARWORDS_LENGTH){
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length == 1){
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }else{
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }else { // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > MAX_STARWORDS_LENGTH){
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
            if (rangeIndex.length == 1){
                textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}


@end
