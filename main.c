
#include <gb/gb.h>
#include <stdio.h>
#include <gb/font.h>
#include <rand.h>
#include <gb/console.h>
#include "Tools/print.h"
#include "Assets/Numbers.c"

void main()
{
    //font_t mini_font;
    //font_init();
    //mini_font = font_load(font_min);
    UINT32 PM =100;
    UINT32 W =0;
    UINT8 S1 =2;
    UINT8 S2 =2;
    UINT8 S3 =2;
    UINT8 cspi = 0;
    UINT8 anim = 0;
    //UINT16 s1;
    //UINT16 s2;
    //UINT16 s3;
    
    
    
    //font_set(mini_font);
    printf("You Have: \nYou Bet: ");

//game loop
    while (1)
    {
       
        /*if (cspi<3){cspi+=1;}else{cspi=0;} 
        set_sprite_tile(0, cspi);*/
        if (W>PM) W=PM;
        

        switch (joypad())
        {
            case J_A:
                S1=(int)(randw()/9362);
                S2=(int)(randw()/9362);
                S3=(int)(randw()/9362);
                if (S1==S2 || S2==S3 || S1==S3)
                {
                    W*=2;
                    PM+=W;
                    W=1;
                }else if (S1==S2 && S2==S3)
                {
                    W*=3;
                    PM+=W;
                    W=1;
                }else{
                    PM-=W;
                    W=1;
                }
                

            break;
            
            case J_LEFT:
                //scroll_sprite(0, -1, 0);
                //set_sprite_prop(anim,S_FLIPX);
            break;
        
            case J_RIGHT:
                //scroll_sprite(0, 1, 0);
                //set_sprite_prop(anim,0);
            break;
            
            case J_UP:
                //scroll_sprite(0, 0, -1);
                W+=1;
                
            break;

            case J_DOWN:
                if (W>1) W-=1;
                //scroll_sprite(0, 0, 1);
            break;

            
        }
        
        printNum(PM,0,88,16,Numbers);
        printNum(W,10,80,25,Numbers);
        set_sprite_data(20,27,Numbers);
        set_sprite_tile(20,S1+40);
        move_sprite(20,80,63);
        set_sprite_tile(21,S2+40);
        move_sprite(21,89,63);
        set_sprite_tile(22,S3+40);
        move_sprite(22,98,63);
        SHOW_SPRITES;
        delay(80);
    }
    
}

