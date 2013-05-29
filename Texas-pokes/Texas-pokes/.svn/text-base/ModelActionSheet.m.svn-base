//
//  ModelActionSheet.m
//  Texas-pokes
//
//  Created by ran on 12-12-27.
//
//

#import "ModelActionSheet.h"

@implementation ModelActionSheet
@synthesize toolBar;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title
{//height = 84, 134, 184, 234, 284, 334, 384, 434, 484
	self = [super init];
    if (self)
	{
		int theight = height - 40;
		int btnnum = theight/50;
		for(int i=0; i<btnnum; i++)
		{
			[self addButtonWithTitle:@" "];
		}
		toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 480, 44)];
		toolBar.barStyle = UIBarStyleDefault;
		
		UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:title style: UIBarButtonItemStylePlain
                                                                       target: nil action: nil];
		UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", nil)
                                                                        style: UIBarButtonItemStyleDone target: self action: @selector(done)];
		UIBarButtonItem *leftButton  = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil)
                                                                        style: UIBarButtonItemStyleBordered target: self
                                                                       action: @selector(docancel)];
		UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
		NSArray *array = [[NSArray alloc] initWithObjects: leftButton,fixedButton, titleButton,fixedButton, rightButton, nil];
		[toolBar setItems: array];
		[titleButton release];
		[leftButton  release];
		[rightButton release];
		[fixedButton release];
		[array       release];
		[self addSubview:toolBar];

        
    }
    return self;
}
-(void)done
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
    if (delegate  && [delegate respondsToSelector:@selector(DoneOrCancle:)])
    {
        [delegate DoneOrCancle:YES];
    }
}
-(void)docancel
{
    
	[self dismissWithClickedButtonIndex:0 animated:YES];
    [delegate DoneOrCancle:NO];
}
-(void)dealloc
{

	[super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
