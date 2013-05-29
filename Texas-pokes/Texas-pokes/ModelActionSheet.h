//
//  ModelActionSheet.h
//  Texas-pokes
//
//  Created by ran on 12-12-27.
//
//

#import <UIKit/UIKit.h>

@protocol BNRUSERCHOOSEINACTIONSHEET <NSObject>

-(void)DoneOrCancle:(BOOL)BiSClickDone;


@end

@interface ModelActionSheet : UIActionSheet
{
    UIToolbar* toolBar;
    id delegate;
}

@property(nonatomic,assign)id delegate;
@property(nonatomic,retain)UIToolbar* toolBar;


-(id)initWithHeight:(float)height WithSheetTitle:(NSString*)title;

@end
