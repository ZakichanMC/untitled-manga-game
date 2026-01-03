sprite_index = type;

if position_meeting(mouse_x,mouse_y,id) and 
mouse_check_button_released(mb_left) {
	if array_contains(oGame.itemEffects,type) {
		array_delete(oGame.itemEffects,array_get_index(oGame.itemEffects,type),1);
		oGame.itemsChosen -= 1;
	}
	else if oGame.itemsChosen < 2 {
		array_push(oGame.itemEffects,type);
		oGame.itemsChosen += 1;
	}
}