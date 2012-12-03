#include "ofMain.h"
#include "testApp.h"

int main(){
    BOOL isRetina,isiPad,iphone5;
    float scaleWidth,scaleHeight;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {    
        if ([[UIScreen mainScreen] scale] > 1)    
            isRetina = true;    
    }    
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])    
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)    
            isiPad = true;    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1)
    {
        isRetina = true;
        isiPad = true;    
        
    }
    
    [pool release];  
    
    int width;  
    int height;  
    
    if (isRetina && isiPad){  
        width = 1536;  
        height = 2048;
        scaleWidth =4.8;
        scaleHeight =4.2666;
    }  
    else if (!isRetina && !isiPad){  
        width = 320;  
        height = 480;
        scaleWidth =1;
        scaleHeight =1;
    }  
    else if (isRetina && !isiPad){  
        width = 640;  
        height = 960;
        scaleWidth =2;
        scaleHeight =2;
    }      
    else if (!isRetina && isiPad){  
        width = 768;  
        height = 1024; 
        scaleWidth =2.4;
        scaleHeight =2.13333;
    }
    
    if ([ [ UIScreen mainScreen ] bounds ].size.height == 568){
        iphone5 = true;
        width = 640;  
        height = 1136; 
        scaleWidth =2;
        scaleHeight =2.36666;
        
    }else{iphone5=false;
        
    }
    
    
    
    ofAppiPhoneWindow * iOSWindow = new ofAppiPhoneWindow();  
    
    ofSetupOpenGL(iOSWindow, width, height, OF_FULLSCREEN);  
    iOSWindow->enableRetinaSupport();  
    
    ofRunApp(new testApp); 
    /*
     the ofSetupOpenGl doesn't really set the size of the device window
     the splashScreens in the Data file do
     */
    
}
