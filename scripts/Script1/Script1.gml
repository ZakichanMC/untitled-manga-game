function printDS(_grid) {
	var _width = ds_grid_width(_grid);
	var _height = ds_grid_height(_grid);
	
	var _list = [];
	for (var _i = 0; _i < _height; ++_i) {
		var _row = [];
		for (var _j = 0; _j < _width; ++_j) {
			array_push(_row,_grid[# _j, _i]); 
		}
		array_push(_list,_row);
	}
	show_debug_message(_list);
}

function cellsContains(_cells,_x,_y) {
    for (var i = 0; i < array_length(_cells); i++)
    {
        if (_cells[i][0] == _x and _cells[i][1] == _y)
            return true;
    }
    return false;
}

function clearGrid(_grid,_potX,_potY,_cells) {
	for (var j=0;j<array_length(_cells);j++) {
		var _px = _potX+_cells[j][0];
		var _py = _potY+_cells[j][1];
		if _potX >= 0 and _potY >= 0 and _px < ds_grid_width(global.grid) and _py < ds_grid_height(global.grid) { //and _px < ds_grid_width(_grid) and _py < ds_grid_height(_grid) {
			_grid[# _px,_py] = 0;
		}
	}
}
