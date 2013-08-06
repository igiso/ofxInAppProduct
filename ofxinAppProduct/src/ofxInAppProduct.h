//
//  ofxInAppProduct.h
//  Samploid
//
//  Created by kyriacos kousoulides on 09/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 Copyright (C) 2012 by kyriacos kousoulides -  www.kousoulides.info
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#ifndef ofxInAppProduct_h
#define ofxInAppProduct_h


#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "SFHFKeychainUtils.h"
extern BOOL otherTransactionInProgress;
extern bool RestoreAllPurchasedItems;
@interface PaymentObserver : NSObject <SKPaymentTransactionObserver> { 
    NSString  * extern_itemName;
    NSString * extern_unlockpass;
    NSString * extern_app_name;
    BOOL purchesed,TRANSACTIONFINISHED,CANCELED;
    UIActivityIndicatorView *indicator;

}
- (void) initialize;
- (void) passInformation: (NSString  *) itemName: (NSString  *)unloackPass: (NSString  *) appName;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (BOOL) isPurchesed;
- (BOOL) TRANSACTION_NOT_COMPLETED;
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue;


@end

class ofxInAppProduct{
    bool restoreTheItem;
    bool purchesed,onlyOneTime;
    NSString  * itemName;
    NSString * unlockpass;
    NSString * app_name;
    char* outfname;
    SFHFKeychainUtils * keyChain;
    SKMutablePayment *payment;
    PaymentObserver *paymentObserver;
    UIAlertView *askToPurchase;
  bool  transactionFinished;    

public:

ofxInAppProduct(string  productName);
~ofxInAppProduct();
    void buy(int units =1);
    void unbuy();
    bool isPurchesed();
    bool isTransactionFinished();
    void reset();
    
};
void restoreAllPreviousTransactions();


#endif
