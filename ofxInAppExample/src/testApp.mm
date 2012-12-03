#include "testApp.h"


//////////////////////////////////////////////////////////////////////////////


    /* 
     
     ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

     To use this Addon on your own projects you must first create an in-app object at Apple's itunesConnect website, and also activate the sandbox account to
     test it.
     if you don't do this then the Addon won't do anything YOU NEED A VALID "Non-Consumable" PRODUCT AND a TEST USER. just like in this example
     
     for the first go to your itunesConnect account and click manage app select app and then "manageinappPurchases"
     and for the -Test User- go to "manage users" and click "Test User"
     
     ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     
     remember to add "StoreKit.framework" && "Security.framework"
     
     How to Add the Frameworks (for newbies) : (xcode 4.2)
     
     
     * Go To: Project (blue logo of Xcode in this case is named Samploid)
     
     * Click: TARGETS  (first thing that appears in the panel that appeared to the right just below Project) : again is named Samploid in this case.
     
     * Click the "Summary" Tab of TARGETS
     
     * Scroll down to: "Linked Frameworks and Libraries" (yellow boxes)
     
     * click the  '+' sign
     
     * type "StoreKit" and ADD it.
     
     * click the '+' again
     
     * type "Security" and Add it.
     
     Done
     ps:
     Good to clean the project after adding a new Framework 
     ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

     Add the addon by #include or #import  and compile.
     
     
     The addon has two constructors
     
     you can either just put the Product ID name of your product
     and the addon will automatically put an unlock password and an appname
     (different for every object you have)
     
     OR:
     
     you can call the other constructor :
     
     
     dubKit = new ofxInAppProduct("alkex.dubstep.toolbox","1234","myAppName");
     
     to specify your own password and appname.
     
     the password it's the word that the addon will use whenever it makes changes to the registry (so that hackers can't 'buy' the products by tweaking xmls etc)
     app name is the username of that. It can be anything but it's good to be the name of your app so that all addons be stored in same place in registry
     
     if you don't specify a password the Addon will set a random one for you.
     
     ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

     
Use a new ofxInAppProduct for each in-App object
     
     
     This Addon is designed and tested to work with "Non-Consumable"
     products (that is products that you buy once.) (not Coins etc)
     
     Feel free to expand it to support other products.
     
     use reset() to fix minor bugs like infinite spining bar or not responding after cancel
     use isTransactionCompleted() to see when user clicked Cancel



    */


//////////////////////////////////////////////////////////////////////////////	


//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
   
    
    
//////////////////////////////////////////////////////////////////////////////	
    

    
    
    
    
        
    
    dubKit = new ofxInAppProduct("alkex.dubstep.toolbox");
    
        
    
    
    
    
    
    
    
    
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    if (dubKit->isPurchesed())
        ofBackground(0, 255, 0);
    else
        ofBackground(255, 0, 0);


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

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    
    
    
    
    
    
    
    
    dubKit->unbuy();
    
    
    
    
    
    
    
    

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

