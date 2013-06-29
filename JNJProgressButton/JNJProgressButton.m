/*
 JNJProgressButton
 
 Copyright (c) 2013 Josh Johnson <jnjosh@jnjosh.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "JNJProgressButton.h"

@interface JNJProgressButton ()

@property (nonatomic, strong) NSMutableDictionary *imageStateStore;

@end

@implementation JNJProgressButton

#pragma mark - Life Cycle

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.imageStateStore = [NSMutableDictionary dictionary];
}

#pragma mark - Progress

- (void)beginProgressing
{
    // TODO(JNJ): Implement
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    self.progress = progress;
}

#pragma mark - Button Images

- (void)setButtonImage:(UIImage *)image
      highlightedImage:(UIImage *)highlightImage
             forStatus:(JNJProgressButtonStatus)status
{
    NSParameterAssert(image);
    
    [self.imageStateStore setObject:image forKey:[self keyForState:UIControlStateNormal status:status]];
    
    if (highlightImage) {
        [self.imageStateStore setObject:highlightImage forKey:[self keyForState:UIControlStateHighlighted status:status]];
    }
}

- (NSString *)keyForState:(UIControlState)state status:(JNJProgressButtonStatus)status
{
    return [NSString stringWithFormat:@"%@-%@", @(state), @(status)];
}

#pragma mark - Actions

- (void)progressButtonWasTapped:(id)sender
{
    if (self.tapAction) {
        self.tapAction(self);
    }
}

#pragma mark - Properties

- (void)setTapAction:(JNJProgressButtonTapAction)tapAction
{
    [self willChangeValueForKey:NSStringFromSelector(@selector(tapAction))];
    _tapAction = [tapAction copy];
    [self didChangeValueForKey:NSStringFromSelector(@selector(tapAction))];
    
    SEL progressButtonSelector = @selector(progressButtonWasTapped:);
    if (_tapAction) {
        [self addTarget:self action:progressButtonSelector forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self removeTarget:self action:progressButtonSelector forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
