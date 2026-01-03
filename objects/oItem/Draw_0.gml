draw_self();
if array_contains(oGame.itemEffects,type) {
	draw_set_color(c_purple);
	draw_rectangle(x,y,x+sprite_width,y+sprite_height,true);
}