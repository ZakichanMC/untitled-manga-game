image_xscale = size[0];
image_yscale = size[1];

draw_set_colour(c_purple);
if dragging and potentialX>=0 and potentialY>=0 and potentialX<ds_grid_width(global.grid) and potentialY<ds_grid_height(global.grid) {
	draw_rectangle(potentialX*16+oPage.x,
					potentialY*16+oPage.y,
					potentialX*16+oPage.x+16*size[0],
					potentialY*16+oPage.y+16*size[1],
					true);
}

for (var j=0;j<size[0];j++) {
	for (var k=0;k<size[1];k++) {
		draw_sprite(sprite_index,0,x+16*j,y+16*k);
	}
}

if position_meeting(mouse_x,mouse_y,id) {
	draw_set_color(c_white);
	draw_set_font(smallFont);
	draw_text(x,y,string(ev));
}