randomise();
show_debug_message(random_get_seed());

global.grid = ds_grid_create(3,4);
panels = array_create(5,noone);
colorsList = [-1,sRed,sBlue,sGreen];

global.ev = 0;
global.hiscore = 0;
myItems = array_create(6,noone);
itemsList = [closeguy,farguy,topleftguy,redguy,blueguy,greenguy];
itemsChosen = 0;
itemEffects = [];