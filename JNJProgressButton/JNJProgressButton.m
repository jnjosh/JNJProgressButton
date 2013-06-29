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
#import <QuartzCore/QuartzCore.h>

@interface JNJProgressButton ()

@property (nonatomic, assign, readwrite) JNJProgressButtonState state;
@property (nonatomic, strong) NSMutableDictionary *imageStateStore;

@property (nonatomic, strong) UIImageView *startButtonImageView;
@property (nonatomic, strong) UIImageView *endButtonImageView;

@property (nonatomic, strong) CALayer *progressButtonLayer;

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
    self.state = JNJProgressButtonStateUnstarted;
    self.imageStateStore = [NSMutableDictionary dictionary];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(progressButtonWasTapped:)]];
    
    self.startButtonImageView = [UIImageView new];
    [self addSubview:self.startButtonImageView];    
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.startButtonImageView.image = [self.imageStateStore objectForKey:@(self.state)];
    self.startButtonImageView.frame = (CGRect) { CGPointZero, self.startButtonImageView.image.size };
    self.startButtonImageView.center = (CGPoint) { CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) };
}

#pragma mark - Accessibility

- (BOOL)isAccessibilityElement
{
    return YES;
}

- (UIAccessibilityTraits)accessibilityTraits
{
    return [super accessibilityTraits] | UIAccessibilityTraitButton;
}

#pragma mark - Progress

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    self.progress = progress;
}

#pragma mark - Action

- (void)progressButtonWasTapped:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.state == JNJProgressButtonStateUnstarted && [self.delegate respondsToSelector:@selector(progressButtonStartButtonTapped:)]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.startButtonImageView.alpha = 0.0;
        }];
        self.state = JNJProgressButtonStateProgressing;
        [self.delegate progressButtonStartButtonTapped:self];
    } else if (self.state == JNJProgressButtonStateProgressing && [self.delegate respondsToSelector:@selector(progressButtonDidCancelProgress:)]) {
        self.state = JNJProgressButtonStateUnstarted;
        [self cancelProgress];
        [self.delegate progressButtonDidCancelProgress:self];
    } else if (self.state == JNJProgressButtonStateFinished && [self.delegate respondsToSelector:@selector(progressButtonEndButtonTapped:)]) {
        [self.delegate progressButtonEndButtonTapped:self];
    }
}

#pragma mark - Button Images

- (void)setButtonImage:(UIImage *)image
      highlightedImage:(UIImage *)highlightImage
              forState:(JNJProgressButtonState)state
{
    NSParameterAssert(image);
    
    [self.imageStateStore setObject:image forKey:@(state)];
    
    if (highlightImage) {
        [self.imageStateStore setObject:highlightImage forKey:@(state)];
    }
}

#pragma mark - Actions

- (void)cancelProgress
{
    [UIView animateWithDuration:0.2 animations:^{
        self.startButtonImageView.alpha = 1.0;
    }];

}

@end
