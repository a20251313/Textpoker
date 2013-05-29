//
//  PublicClass.m
//  Texas-pokes
//
//  Created by ran on 13-1-29.
//
//

#import "PublicClass.h"
#import "UserInfo.h"
#import "PublicVarible.h"

@implementation PublicClass


+(void)storeMessage:(NSString *)strMsg type:(int) type
{
    id   strKey = MESSAGEUSERINFOINLOCAL;
    if (type == 1)
    {
        strKey = MESSAGESYSLOCAL;
    }
    NSMutableArray  *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:strKey]];
    [array insertObject:[NSDictionary dictionaryWithObjectsAndKeys:strMsg,MESSAGECONTENT,[[NSDate date] description],MESSAGEDATE,@(type),MESSAGETYPE, nil] atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:strKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


//得到中英文混合字符串长度 方法1
- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

//得到中英文混合字符串长度 方法2
- (int)getToInt:(NSString*)strtemp

{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return [da length];
}


/*
- (int)keyCodeForCharacter: (NSString*)character {
    if(![character length]) return -1;
    
    char code;
    BOOL shift, alt;
    if(Ascii2Virtual( (char)[character characterAtIndex: 0],shift,alt,code)) {
        return code;
    }
    return -1;
}

BOOL Ascii2Virtual(char pcar, BOOL *pshift, BOOL *palt, char *pkeycode)
{
    KeyboardLayoutRef keyboard;
    const void *keyboardData; // keyboard layout data
    UInt16 nbblocs;
    char *modblocs, *blocs, *deadkeys;
    int ix, ifin, numbloc, keycode;
    
    BOOL shift, alt;
    // get the current keyboard
    if(KLGetCurrentKeyboardLayout(&keyboard;)) return NO;
    // get the description of the current keyboard layout
    if(KLGetKeyboardLayoutProperty(keyboard, kKLKCHRData, &keyboardData;)) return NO;
    // get pointer early numbers of blocks for each combination of modifiers
    modblocs = ((char *)keyboardData) + 2;
    // get number of blocks keycode->ascii
    nbblocs = *((UInt16 *)(keyboardData + 258));
    // get pointer early blocks keycode-> ascii
    blocs = ((char *)keyboardData) + 260;
    // determining the size of all tables keycode-> ascii a scanner
    ifin = nbblocs*128;
    // determining pointer early in the tables of dead keys
    deadkeys = blocs+ifin;
    // Now it runs blocks keycode-> ascii to find the car ascii
    for (ix=0; ix<ifin ; ix++)
    {
        if (blocs[ix]==pcar)
        {
            
            // found ascii value: now we must determine which block it is
            keycode = ix & 0×7f; // 0111 1111 mask
            numbloc = ix >> 7;
            break;
        }
    }
    
    // not found: bail out (error)
    if (ix >= ifin) return NO;
    
    // from block number, we must find the combination of modifiers using this block
    for (ix=0; ix<15; ix++)
    {
        // it does not address whether the modifiers are not "capital" and "option"
        if (ix&1 || ix&4) continue;
        // Combining modifiers found for the block
        if (modblocs[ix]==numbloc)
        {
            shift = (ix&2) ? YES : NO;
            alt   = (ix&8) ? YES : NO;
            break;
        }
    }
    // combination modifiers not found: bail
    if (ix>=15) return NO;
    // save our parameters
    *pkeycode=keycode;
    *pshift=shift;
    *palt=alt;
    
    return YES;
}*/

//arc4random() 比较精确不需要生成随即种子
//通过arc4random() 获取0到x-1之间的整数的代码如下：
//int value = arc4random() % x;
//获取1到x之间的整数的代码如下:
//int value = (arc4random() % x) + 1;

//CCRANDOM_0_1() cocos2d中使用 ，范围是[0,1]
//float random = CCRANDOM_0_1() * 5; //[0,5]   CCRANDOM_0_1() 取值范围是[0,1]

//random() 需要初始化时设置种子
//srandom((unsigned int)time(time_t *)NULL); //初始化时，设置下种子就好了。


/*Calculate the size necessary for the UILable
NSString *theText = @"Texting";
CGSize theStringSize = [theText sizeWithFont:font
                           constrainedToSize:theLabel.frame.size
                               lineBreakMode:theLabel.lineBreakMode];

//Adjust the size of the UILable
theLable.frame = CGRectMake(theLable.frame.origin.x,
                            theLable.frame.origin.y,
                            theStringSize.width, theStringSize.height);
theLable.text = theText;

- (void)makeCall:(NSString *)number
{
    NSString *txt = number;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]{4}[-]{0,1}[0-9]{4}?" options:NSRegularExpressionSearch error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:txt options:0 range:NSMakeRange(0, [txt length])];
    NSString *cleanedString = [[[txt substringWithRange:[result range]] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSString *escapedPhoneNumber = [cleanedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", escapedPhoneNumber]];
    [[UIApplication sharedApplication] openURL:telURL];
}*/

@end
