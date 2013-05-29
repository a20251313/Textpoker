#ifndef __MYSECURITY_INC_MYCHALLENGEKEY_H__
#define __MYSECURITY_INC_MYCHALLENGEKEY_H__

namespace MyChallengeKey
{
    unsigned int getRAChallengeKeyLen();
    const unsigned char *getRAChallengeKey();

    unsigned int getIOSTokenChallengeKeyLen();
    const unsigned char *getIOSTokenChallengeKey();    
}

#endif /* __MYSECURITY_INC_MYCHALLENGEKEY_H__ */
