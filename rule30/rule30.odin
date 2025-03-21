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
		run_rule_30 :: proc() {

			// bang, nil, nil
			// nil, bang, bang
			// nil, bang, nil
			// nil, nil, bang

		}
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
