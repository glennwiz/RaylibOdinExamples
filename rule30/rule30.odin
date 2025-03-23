package rule30

import "core:fmt"
import rl "vendor:raylib"

SCREEN_WIDTH :: 1024
SCREEN_HEIGHT :: 768

cell_size: i32 = 2
x_cell_count := SCREEN_WIDTH / cell_size
y_cell_count := SCREEN_HEIGHT / cell_size

Grid :: [dynamic][dynamic]bool
grid: Grid

current_generation: i32 = 0

main :: proc() {
	fmt.println("Rule 30")

	rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Rule30")
	defer rl.CloseWindow()

	grid = make([dynamic][dynamic]bool, y_cell_count)
	for i in 0 ..< y_cell_count {
		grid[i] = make([dynamic]bool, x_cell_count)
	}

	middle_seed := x_cell_count / 2
	grid[0][middle_seed] = true
	current_generation = 1

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.GRAY)

		the_grid()
		draw_cells()
		if current_generation < y_cell_count {
			run_rule_30()
			current_generation += 1
		}
		rl.EndDrawing()
	}
}

the_grid :: proc() {
	for x in 0 ..= x_cell_count {
		rl.DrawLine(x * cell_size, 0, x * cell_size, SCREEN_HEIGHT, rl.BLACK)
	}
	for y in 0 ..= y_cell_count {
		rl.DrawLine(0, y * cell_size, SCREEN_WIDTH, y * cell_size, rl.BLACK)
	}
}

draw_cells :: proc() {
	for y in 0 ..< current_generation {
		for x in 0 ..< x_cell_count {
			if grid[y][x] {
				rl.DrawRectangle(x * cell_size, y * cell_size, cell_size, cell_size, rl.BLACK)
			}
		}
	}
}

run_rule_30 :: proc() {
	// https://en.wikipedia.org/wiki/Rule_30

	prev_row := current_generation - 1
	current_row := current_generation

	for x in 0 ..< x_cell_count {
		left := x > 0 ? grid[prev_row][x - 1] : false
		current := grid[prev_row][x]
		right := x < x_cell_count - 1 ? grid[prev_row][x + 1] : false

		grid[current_row][x] =
			(!left && current && right) ||
			(left && !current && !right) ||
			(!left && current && !right) ||
			(!left && !current && right)
	}
}
