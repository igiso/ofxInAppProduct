#include "testApp.h"


//////////////////////////////////////////////////////////////////////////////

    /* 
     

     Updates:
     
     * Consumable support :
     
  ::   if(coins->isPurchased()){add 100 coins; coins->unbuy();}
     
     
     
     
     * ability to buy more than 1 product 
  ::  coinPack->buy(4);
     
     
     
     
     * added restoreAllproductsSupport 
     
     
  ::  it restores all NON-CONSUMABLE products if the user bought them before..
     
     
     -INSTRUCTIONS-
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     add "StoreKit.framework" && "Security.framework"
     

     
     To use this Addon on your own projects you must first create an in-app object at Apple's itunesConnect website, and also activate the sandbox account to
     test it.
     if you don't do this then the Addon won't do anything YOU NEED A VALID PRODUCT id AND a TEST USER. just like in this example
     
     for the first go to your itunesConnect account and click manage app select app and then "manageinappPurchases"
     and for the -Test User- go to "manage users" and click "Test User"
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
       
     
     
     
     
     
     
     
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

     
Use a new ofxInAppProduct for each new appID
     


    */


//////////////////////////////////////////////////////////////////////////////	


//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
   
    
    
//////////////////////////////////////////////////////////////////////////////	
    

    
    
    
    
        
    
    dubKit = new ofxInAppProduct("com.kousoulides.word.unlock");//non-consumable
    
    coins = new ofxInAppProduct("com.kousoulides.word.kermata");//consumable
    
        
    
    
    
    
    
    restoreAllPreviousTransactions();
    
    
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    if (dubKit->isPurchesed())
        ofBackground(0, 255, 0);
    else
        ofBackground(255, 0, 0);
    
    
    if(coins->isPurchesed()){

      //  MyCoins +=100;
        
        coins->unbuy();
    }
    


}

//--------------------------------------------------------------
void testApp::draw(){
           
        

    if (dubKit->isTransactionFinished())dubKit->reset();else 
ofDrawBitmapString("making a transaction..", ofGetWidth()/2-90,ofGetHeight()/2+50);   
    
    

}

//--------------------------------------------------------------
void testApp::exit(){
    
    delete dubKit;

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    
    
    
    
    
    
    
    
    
    
    dubKit->buy();
    
    //or

    //coin->buy(2);

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    

}


//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    
    
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
}


//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

