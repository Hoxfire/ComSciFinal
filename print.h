#include <gb/gb.h>
#include <stdio.h>
#include <gb/drawing.h>

int pow(int x, int y){
    int s=1;
    if (y==0)
    {
        return 1;
    }
    if (y<0)
    {
        return 0;
    }
    
    for (size_t i = 0; i < y; i++)
    {
        s*=x;
    }
    return s;
}

void printNum(UINT32 n, UINT8 nb,UINT8 x, UINT8 y, const unsigned char *data){
    
    /*
    UINT32 n1,n2,n3;
    set_sprite_data(nb,nb+10,data);
    n1=n/100;
    if (n1==0) {
        n1=0;
    }else if(n1>=9){
        n1=9;
    }
    set_sprite_tile(nb, n1);
    move_sprite(nb, x, y);
    n2=n/10;
    if (n2==0) {
        n2=0;
    }else if(n2>=99){
        n2=99;
    }
    set_sprite_tile(nb+1,n2-(n1*10));
    move_sprite(nb+1, x+8, y);
    n3=n;
    if (n3==0) {
        n3=0;
    }else if(n3>=999){
        n3=999;
    }
    set_sprite_tile(nb+2,n3-(n2*10));
    move_sprite(nb+2,x+16,y);
    */
    int c=1;
    set_sprite_data(nb,nb+10,data);
    UINT32 n1;
    UINT32 n2=0;
    for (int i = 3; i > 0; i--)
    {
        n1 = n/(pow(10,i-1));
        set_sprite_tile(nb+c, n1-(n2*10));
        move_sprite(nb+c, x+(8*(3-i)), y);
        c++;
        n2=n1;
    }

}

