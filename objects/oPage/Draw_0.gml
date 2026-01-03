image_xscale = size[0];
image_yscale = size[1];

for (var j=0;j<size[0];j++) {
	for (var k=0;k<size[1];k++) {
		draw_sprite(sprite_index,0,x+16*j,y+16*k);
	}
}