//
//  ofxInAppProduct.mm
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


#include <iostream>
#include "ofxInAppProduct.h"

BOOL otherTransactionInProgress=false;

bool RestoreAllPurchasedItems;

@implementation PaymentObserver

- (void) initialize{
    TRANSACTIONFINISHED=NO;
    CANCELED=NO;
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    CGPoint p;
    p = ofxiPhoneGetGLView().center;
    indicator.center = p;
    [ofxiPhoneGetGLView() addSubview: indicator];
    [indicator bringSubviewToFront:ofxiPhoneGetGLView()];
    [indicator startAnimating];

}
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    purchesed=false;
}
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    if ([queue.transactions count] == 0)
    {
        UIAlertView *restorealert = [[UIAlertView alloc]
                                     initWithTitle:@"Restore"
                                     message:@"No products purchased?"
                                     delegate:self
                                     cancelButtonTitle:@"Ok"
                                     otherButtonTitles:nil];
        
        [restorealert show];
        
        
    }
    else
    {
        NSString *productID;
        NSString *username;
        NSString *unlockPass;
        
        
        
        for(SKPaymentTransaction *transaction in queue.transactions)
        {
            productID = transaction.payment.productIdentifier;
            NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
            NSString *bundleName = [NSString stringWithFormat:@"%@", [info objectForKey:@"CFBundleDisplayName"]];
            string standardAppName = [bundleName UTF8String];
            
            
            string standardUnlocKey = ofToDataPath(productID.UTF8String).c_str();
            standardUnlocKey.insert(standardUnlocKey.size(),standardAppName);
            
            
            unlockPass = [[NSString alloc]initWithString:[NSString stringWithUTF8String: standardUnlocKey.c_str()]];
            if (standardAppName.size()==0) {
                cout<<"ofxInAppProduct::Warning:: Couldn't get Project's name: Using a Standard name instead::::";
                standardAppName = ofToDataPath(productID.UTF8String).c_str();
                standardAppName.insert(standardAppName.size(),"_OFAPP");
            }
            username = [[NSString alloc]initWithString:[NSString stringWithUTF8String: standardAppName.c_str()]];
            
            NSError *error = nil;
            [SFHFKeychainUtils storeUsername:username andPassword:unlockPass forServiceName:productID updateExisting:YES error:&error];
            RestoreAllPurchasedItems= true;
            
            [username release];
            [unlockPass release];
            cout<<"Restore Item: ..."<<productID.UTF8String<<endl;
            //[[SKPaymentQueue defaultQueue] removeTransactionObserver:self];

        }
        
    }
    [indicator stopAnimating];

}


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    TRANSACTIONFINISHED = !TRANSACTIONFINISHED;
    if(TRANSACTIONFINISHED){
        
    }else{
        cout<<"finishing.."<<endl;
        
        }
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                otherTransactionInProgress=NO;
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                otherTransactionInProgress=NO;
                break;
            case SKPaymentTransactionStatePurchasing:
                cout<<".................................."<<endl;
                cout<<".................................."<<endl;
                cout<<".................................."<<endl;
                cout<<extern_itemName.UTF8String<<" :::::::ITEMNAME::::::"<<endl;
                cout<<".................................."<<endl;
                
                cout<<extern_unlockpass.UTF8String<<" :::::::extern_unlockpass::::::"<<endl;
                cout<<".................................."<<endl;
                
                cout<<extern_app_name.UTF8String<<" :::::::extern_app_name::::::"<<endl;
                cout<<".................................."<<endl;
                cout<<".................................."<<endl;
                cout<<".................................."<<endl;
                cout<<".................................."<<endl;

                
                cout<< "Processing..."<<endl;
                break;

            case SKPaymentTransactionStateRestored:
                
                [self restoreTransaction:transaction];
                otherTransactionInProgress=NO;
                break;
            default:
                    purchesed = NO;
                break;
        }
    }
}



- (void) completeTransaction: (SKPaymentTransaction *)transaction;
{
   
    if (!CANCELED) {
    purchesed = YES;
    cout<<"Completing Transaction for item:: "<<[extern_itemName UTF8String];
    cout<<endl;
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:extern_app_name andPassword:extern_unlockpass forServiceName:extern_itemName updateExisting:YES error:&error];
    
    cout<<"DONE!";
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [indicator stopAnimating];

    
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
   
    purchesed = YES;
    
    cout<<"Restoring Transaction for item:: "<<[extern_itemName UTF8String];
    cout<<endl;
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:extern_app_name andPassword:extern_unlockpass forServiceName:extern_itemName updateExisting:YES error:&error];
    
    cout<<"DONE!";

    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [indicator stopAnimating];


}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{  
    
    CANCELED = YES;
    cout<<"CANCELED!!";
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        purchesed = NO;
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    [indicator stopAnimating];


}
- (void) passInformation:(NSString *)itemName :(NSString *)unloackPass :(NSString *)appName{
    
    extern_itemName = itemName;
    extern_unlockpass = unloackPass;
    extern_app_name = appName;

    
}



- (BOOL) isPurchesed{
        NSError *error = nil;
    NSString *pass_AtkeyCain = [SFHFKeychainUtils getPasswordForUsername:extern_app_name andServiceName:extern_itemName error:&error];
    
if ([pass_AtkeyCain isEqualToString:extern_unlockpass])return YES; else return  NO;
   


}

- (BOOL) TRANSACTION_NOT_COMPLETED{
    
    return TRANSACTIONFINISHED;
}
- (void) releaseB {
    [indicator release];
}


@end



ofxInAppProduct::ofxInAppProduct(string  ProductName){
purchesed =false;
RestoreAllPurchasedItems=false;
restoreTheItem=false;
    
itemName =    [[NSString alloc]initWithString:[NSString stringWithCString:ProductName.c_str() encoding:NSASCIIStringEncoding]];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleName = [NSString stringWithFormat:@"%@", [info objectForKey:@"CFBundleDisplayName"]];
    string standardAppName = [bundleName UTF8String];

    string standardUnlocKey = ofToDataPath((string)ProductName).c_str();
    standardUnlocKey.insert(standardUnlocKey.size(),standardAppName);

unlockpass = [[NSString alloc]initWithString:[NSString stringWithUTF8String: standardUnlocKey.c_str()]];
    if (standardAppName.size()==0) {
        cout<<"ofxInAppProduct::Warning:: Couldn't get Project's name: Using a Standard name instead::::";
        standardAppName = ofToDataPath((string)ProductName).c_str();
        standardAppName.insert(standardAppName.size(),"_OFAPP");
    }
app_name = [[NSString alloc]initWithString:[NSString stringWithUTF8String: standardAppName.c_str()]];    
    NSError *error = nil;
    NSString *pass_AtkeyCain = [SFHFKeychainUtils getPasswordForUsername:app_name andServiceName:itemName error:&error];
    if ([pass_AtkeyCain isEqualToString:unlockpass])purchesed=true; else purchesed =false;
    onlyOneTime = false;
    transactionFinished=true;
    paymentObserver =nil;
    if(purchesed)cout<<"THE ITEM: "<<[itemName UTF8String]<<" IS PURCHASED";else cout<<"NOT PURCHESED ITEM!";
    cout<<endl;
}


void ofxInAppProduct::buy(int units){
if (!purchesed) {
    if (!onlyOneTime&&itemName!=nil&&!otherTransactionInProgress) {
        if([SKPaymentQueue canMakePayments]){
        otherTransactionInProgress=YES;

 
        transactionFinished=false;    

    cout<<endl<<endl<<":TRANSACTION REQUEST:"<<endl;
if (paymentObserver==nil) {
payment = [[SKMutablePayment alloc] init] ;
paymentObserver = [[PaymentObserver alloc] init];
            }
            [paymentObserver initialize];                       
            payment.productIdentifier = itemName;
            payment.quantity = units;
    [paymentObserver passInformation:itemName :unlockpass :app_name];
[[SKPaymentQueue defaultQueue] addTransactionObserver:paymentObserver];        
[[SKPaymentQueue defaultQueue] addPayment:payment];
           
    onlyOneTime=true;
        }else{
                     cout<<"PARENTAL CONTROL IS ENABLED!";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry.." 
                                                            message:@"Parental Control is Enabled"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK" 
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];

            
        }

    
    
        
    }else{
        if (onlyOneTime&&![paymentObserver TRANSACTION_NOT_COMPLETED]) {
            transactionFinished=true;
           
            
            [[SKPaymentQueue defaultQueue] removeTransactionObserver:paymentObserver];

            
        }
        
    }

}

}

bool ofxInAppProduct::isPurchesed(){
    
    if(!purchesed&&onlyOneTime){

        purchesed = this->paymentObserver.isPurchesed;

    }
    if (purchesed){
   
    if(onlyOneTime)[[SKPaymentQueue defaultQueue] removeTransactionObserver:paymentObserver];

    }
    if (onlyOneTime&&![paymentObserver TRANSACTION_NOT_COMPLETED]){
        transactionFinished=true;
    }
    
  
    
    if (RestoreAllPurchasedItems) {
        
        if(!restoreTheItem){
        cout<<"RESTORING"<<endl;
        NSError *error = nil;
        NSString *pass_AtkeyCain = [SFHFKeychainUtils getPasswordForUsername:app_name andServiceName:itemName error:&error];
        if ([pass_AtkeyCain isEqualToString:unlockpass])purchesed=true; else purchesed =false;
    restoreTheItem=true;

    }
    
    }
        
        //            purchesed = this->paymentObserver.isPurchesed;
//            restoreTheItem=true;
            
    
    return purchesed;
}

void ofxInAppProduct::unbuy(){
    
    NSError *error = nil;  
    
    if([SFHFKeychainUtils deleteItemForUsername:app_name andServiceName:itemName error:&error]){
        this->purchesed = false;
        this->onlyOneTime= false;
    cout<<"PRODUCT UNPURCHASED"<<endl;
    }
    
}

bool ofxInAppProduct::isTransactionFinished(){
    
    return  transactionFinished;    

}
void ofxInAppProduct::reset(){
if (transactionFinished)onlyOneTime=false;
}

ofxInAppProduct::~ofxInAppProduct(){
    [itemName release];
    [unlockpass release];
    [app_name release];

    if(paymentObserver!=nil){
        [paymentObserver releaseB];
        [paymentObserver release];
        [payment release];
    }

    
}

void restoreAllPreviousTransactions(){
        PaymentObserver *paymentObserver;
        paymentObserver = [PaymentObserver new];
        [paymentObserver initialize];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:paymentObserver];
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}



