//calculate current ev
var _sum = 0
for (var p=0;p<array_length(panels);p++) {
	if panels[p] != noone and panels[p].prevGridX != -1 and panels[p].prevGridY != -1 {
		_sum += panels[p].ev;
	}
}
global.ev = _sum;

//create new panels and items
if keyboard_check_pressed(vk_space) {
	for (var i=0;i<5;i++) {
		size = [irandom_range(1,2),irandom_range(1,2)];
		var _panel = instance_create_layer(250,4+36*i,"Instances",oPanels);
		_panel.sprite_index = colorsList[irandom_range(1,3)];
		_panel.size = size;
		for (var j=0;j<size[0];j++) {
			for (var k=0;k<size[1];k++) {
				array_push(_panel.cells,[j,k]);
			}
		}
		_panel.ev = power(2,array_length(_panel.cells));
		_panel.origEV = _panel.ev;
		if (panels[i] != noone) {
			//if (panels[i].prevGridX != -1) global.ev += panels[i].ev;
			clearGrid(global.grid,panels[i].potentialX,panels[i].potentialY,panels[i].cells);
			instance_destroy(panels[i]);
		}
		panels[i] = _panel;
	}
	
	for (var l=0;l<array_length(myItems);l++) {
		if myItems[l] != noone instance_destroy(myItems[l]);
		var _item = instance_create_layer(48+l*32,16,"Instances",oItem);
		_item.type = itemsList[l];
		myItems[l] = _item;
	}
	
	itemsChosen = 0;
	itemEffects = [];
	
	if (global.ev > global.hiscore) global.hiscore = global.ev;
	global.ev = 0;
}
