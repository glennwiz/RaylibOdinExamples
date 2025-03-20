package rule30

import "core:fmt"
import "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 800

cell_size: i32 = 5

main :: proc() {
	fmt.println("Gnipahellir")

	raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Rule30")
	defer (raylib.CloseWindow())

	x_cell_count := SCREEN_WIDTH / cell_size
	y_cell_count := SCREEN_HEIGHT / cell_size

	for !raylib.WindowShouldClose() {

		// bang, nil, nil
		// nil, bang, bang
		// nil, bang, nil
		// nil, nil, bang
		raylib.BeginDrawing()
		for x: i32 = 5; x < x_cell_count; x += 5 { 	//valid, i autoincrement 

			raylib.DrawLine(x, SCREEN_HEIGHT)

			for n: i32 = 0; n < y_cell_count; n += 1 { 	//valid
			}
		}
		raylib.EndDrawing()
	}
}
