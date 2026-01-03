if (!dragable) exit;

// start dragging
if (!dragging and mouse_check_button_pressed(mb_left)
and position_meeting(mouse_x, mouse_y, id)) {
    dragging = true;

    relX = x - mouse_x;
    relY = y - mouse_y;
	
	//printDS(global.grid);
	//show_debug_message(string(prevGridX)+string(prevGridY));
    clearGrid(global.grid, prevGridX, prevGridY, cells);
}


// while dragging
if (dragging and mouse_check_button(mb_left)) {
    x = mouse_x + relX;
    y = mouse_y + relY;
    depth = -100;
	
	var _minDist = infinity;
	var _closest = [0,0];
	for (var j=0;j<ds_grid_width(global.grid);j++) {
		for (var k=0;k<ds_grid_height(global.grid);k++) {
			var _dist = point_distance(x,y,oPage.x+j*16,oPage.y+k*16);
			if _dist < _minDist {
				_minDist = _dist;
				_closest = [j,k];
			}
		}
	}

    if _minDist <= 20 {
        potentialX = _closest[0];
        potentialY = _closest[1];
    } 
	else {
        potentialX = -1;
        potentialY = -1;
    }
}


// stop dragging
if (dragging and !mouse_check_button(mb_left))
{
    var valid = (potentialX >= 0 and potentialY >= 0);

    // validate placement
    if (valid) {
        for (var i = 0; i < array_length(cells); i++) {
            var gx = potentialX + cells[i][0];
            var gy = potentialY + cells[i][1];

            if (gx < 0 or gy < 0 or
                gx >= ds_grid_width(global.grid) or
                gy >= ds_grid_height(global.grid) or
                global.grid[# gx, gy] != 0)
            {
                valid = false;
                break;
            }
        }
    }

    if (valid) {
        prevGridX = potentialX;
        prevGridY = potentialY;

        x = prevGridX * 16 + oPage.x;
        y = prevGridY * 16 + oPage.y;
    }
    else { // if invalid
		var _minDist = infinity;
		var _closest = [0,0];
		for (var j=0;j<ds_grid_width(global.grid);j++) {
			for (var k=0;k<ds_grid_height(global.grid);k++) {
				var _dist = point_distance(x,y,oPage.x+j*16,oPage.y+k*16);
				if _dist < _minDist {
					_minDist = _dist;
					_closest = [j,k];
				}
			}
		}
		//show_debug_message(_closest);
	    if (_minDist <= 20)
			and (prevGridX >= 0 and prevGridY >= 0) {
	        x = prevGridX * 16 + oPage.x;
	        y = prevGridY * 16 + oPage.y;
	    }
	    else {
	        if (prevGridX >= 0 and prevGridY >= 0) {
	            clearGrid(global.grid, prevGridX, prevGridY, cells);
	        }

	        prevGridX = -1;
	        prevGridY = -1;

	        x = origX;
	        y = origY;
	    }
	}


    // write piece back into grid 
	if (prevGridX >= 0 && prevGridY >= 0) {
	    for (var i = 0; i < array_length(cells); i++) {
	        var wx = prevGridX + cells[i][0];
	        var wy = prevGridY + cells[i][1];
	        global.grid[# wx, wy] =
	            array_get_index(oGame.colorsList, sprite_index);
	    }
	}

    depth = -10;
    dragging = false;
}

// check ev
if potentialX>=0 and potentialY>=0 {
	var _surrounding = [];
	var _numSame = 0;
	var _numDiff = 0;
	for (var l=0;l<array_length(cells);l++) {
		var _cx = potentialX+cells[l][0];
		var _cy = potentialY+cells[l][1];
		if _cx>=0 and _cx<ds_grid_width(global.grid) and _cy>=0 and _cy<ds_grid_height(global.grid) {
			//left
			if _cx-1>=0 and _cx-1<ds_grid_width(global.grid) and !cellsContains(cells,(_cx-1)-potentialX,_cy-potentialY) and !cellsContains(_surrounding,_cx-1,_cy) {
				array_push(_surrounding,[_cx-1,_cy,global.grid[# _cx-1,_cy] == global.grid[# _cx,_cy] and global.grid[# _cx-1,_cy]!=0]);
			}
			//right
			if _cx+1>=0 and _cx+1<ds_grid_width(global.grid) and !cellsContains(cells,(_cx+1)-potentialX,_cy-potentialY) and !cellsContains(_surrounding,_cx+1,_cy) {
				array_push(_surrounding,[_cx+1,_cy,global.grid[# _cx+1,_cy] == global.grid[# _cx,_cy] and global.grid[# _cx+1,_cy]!=0]);
			}
			//up
			if _cy-1>=0 and _cy-1<ds_grid_height(global.grid) and !cellsContains(cells,_cx-potentialX,(_cy-1)-potentialY) and !cellsContains(_surrounding,_cx,_cy-1) {
				array_push(_surrounding,[_cx,_cy-1,global.grid[# _cx,_cy-1] == global.grid[# _cx,_cy] and global.grid[# _cx,_cy-1]!=0]);
			}
			//down
			if _cy+1>=0 and _cy+1<ds_grid_height(global.grid) and !cellsContains(cells,_cx-potentialX,(_cy+1)-potentialY) and !cellsContains(_surrounding,_cx,_cy+1) {
				array_push(_surrounding,[_cx,_cy+1,global.grid[# _cx,_cy+1] == global.grid[# _cx,_cy] and global.grid[# _cx,_cy+1]!=0]);
			}
		}
	}
	for (var m=0;m<array_length(_surrounding);m++) {
		if (_surrounding[m][2]) _numSame += 1;
		else if global.grid[# _surrounding[m][0],_surrounding[m][1]] != 0 _numDiff += 1;
	}
	var _newEV = 0;
	if array_contains(oGame.itemEffects,closeguy) {
		_newEV += _numSame * 5;
	}
	if array_contains(oGame.itemEffects,farguy) {
		_newEV += _numDiff * 10;
	}
	if array_contains(oGame.itemEffects,topleftguy) {
		_newEV += origEV*(potentialX == 0 and potentialY == 0)*5;
	}
	if array_contains(oGame.itemEffects,redguy)
		and global.grid[# potentialX,potentialY] == 1 {
		_newEV += 10;
	}
	if array_contains(oGame.itemEffects,blueguy)
		and global.grid[# potentialX,potentialY] == 2 {
		_newEV += 10;	
	}
	if array_contains(oGame.itemEffects,greenguy)
		and global.grid[# potentialX,potentialY] == 3 {
		_newEV += 10;	
	}
	ev = origEV + _newEV;
}