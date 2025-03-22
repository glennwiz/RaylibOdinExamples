package rule30

import "core:fmt"
import "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 800

cell_size: i32 = 20
x_cell_count := SCREEN_WIDTH / cell_size
y_cell_count := SCREEN_HEIGHT / cell_size

main :: proc() {
	fmt.println("Gnipahellir")

	raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Rule30")
	defer (raylib.CloseWindow())


	for !raylib.WindowShouldClose() {

		raylib.BeginDrawing()
		raylib.ClearBackground(raylib.GRAY)

		the_grid()
		run_rule_30()
		raylib.EndDrawing()
	}
}

the_grid :: proc() {

	for x: i32 = 1; x < x_cell_count; x += 1 {

		//DrawLine :: proc(startPosX, startPosY, endPosX, endPosY: c.int, color: Color) ---
		raylib.DrawLine(cell_size * x, 0, cell_size * x, SCREEN_HEIGHT, raylib.BLACK)

		for n: i32 = 0; n < y_cell_count; n += 1 {
			raylib.DrawLine(0, cell_size * x, SCREEN_HEIGHT, cell_size * x, raylib.BLACK)
		}
	}
}

GRID :: [2][dynamic]bool
grids: GRID

run_count: i32 = 10

run_rule_30 :: proc() {


	// https://en.wikipedia.org/wiki/Rule_30
	// bang, nil, nil
	// nil, bang, bang
	// nil, bang, nil
	// nil, nil, bang

	//DrawRectangle               :: proc(posX, posY: c.int, width, height: c.int, color: Color) ---
	raylib.DrawRectangle(SCREEN_WIDTH / 2, 0, cell_size, cell_size, raylib.BLACK)


	//we two temp lookup grids i belive with that can hold bool, that holds the stat of the line above[0] and updates the line we are on [1]
	//we swap [0] with [1] and clear the new [1] after every update.

	for i: i32 = 1; i < run_count; i += 1 {

		row_loc := cell_size * i
		//line down the middle -> raylib.DrawRectangle(SCREEN_WIDTH / 2, row_loc, cell_size, cell_size, raylib.BLACK)

		column_loc := SCREEN_WIDTH / cell_size

		for y: i32 = 1; i < column_loc; y += 1 {


		}
	}
}
