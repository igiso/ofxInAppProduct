#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	




    coins = new ofxInAppProduct("com.kousoulides.word.kermata");//consumable
    unlock = new ofxInAppProduct("com.kousoulides.word.unlock");
    litleHelpers = new ofxInAppProduct("com.kousoulides.word.litlehelpers");
    
   // restoreAllPreviousTransactions();
    unlock->buy();
    
}

//--------------------------------------------------------------
void testApp::update(){
    

}

//--------------------------------------------------------------
void testApp::draw(){
    
    
    if (coins->isPurchesed()) {
        
        ///add 100 coins
        
        coins->unbuy();//only consumables should call this
    }
    if (unlock->isPurchesed()) {
        ofSetColor(255, 152, 249);
        ofRect(40, 0, 40, 40);
    }
    if (litleHelpers->isPurchesed()) {
        ofSetColor(0, 152, 249);
        ofRect(80, 0, 40, 40);
    }

    

	
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
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

