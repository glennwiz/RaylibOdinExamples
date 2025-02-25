package main

import r "base:runtime"
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

Button :: struct {
	rect:        rl.Rectangle,
	color:       rl.Color,
	hover_color: rl.Color,
	text:        cstring,
	action:      proc(),
}

Circle :: struct {
	x, y, radius: f32,
	color:        rl.Color,
}

screen_width, screen_height := 800, 600
bg_color := rl.BLACK
circles: [dynamic]Circle

main :: proc() {

	rl.InitWindow(i32(screen_width), i32(screen_height), "Odin rl - 4 Random Buttons")
	rl.SetTargetFPS(60)

	buttons := [4]Button {
		// Button 1
		{
			rect = {100, 100, 200, 80},
			color = rl.BLUE,
			hover_color = {0, 0, 100, 255}, // Dark blue
			text = "Change Background",
			action = proc() {
				bg_color.r = u8(rand.int_max(255))
				bg_color.g = u8(rand.int_max(255))
				bg_color.b = u8(rand.int_max(255))
			},
		},
		// Button 2
		{
			rect = {100, 200, 200, 80},
			color = rl.RED,
			hover_color = {100, 0, 0, 255}, // Dark red
			text = "Spawn Circles",
			action = proc() {
				for i in 0 ..< 10 {
					x := f32(rand.int_max(screen_width))
					y := f32(rand.int_max(screen_height))
					radius := f32(10 + rand.int_max(20))
					circle_color := rl.Color {
						u8(rand.int_max(255)),
						u8(rand.int_max(255)),
						u8(rand.int_max(255)),
						255,
					}
					r.append_elem(&circles, Circle{x, y, radius, circle_color})
				}
			},
		},
		// Button 3
		{
			rect = {100, 300, 200, 80},
			color = rl.GREEN,
			hover_color = {0, 100, 0, 255}, // Dark green
			text = "Clear Circles",
			action = proc() {
				r.clear_dynamic_array(&circles)
			},
		},
		// Button 4
		{
			rect = {100, 400, 200, 80},
			color = rl.PURPLE,
			hover_color = {100, 0, 100, 255}, // Dark purple
			text = "Random Window Size",
			action = proc() {
				new_width := 400 + rand.int_max(600)
				new_height := 400 + rand.int_max(400)
				rl.SetWindowSize(i32(new_width), i32(new_height))
			},
		},
	}

	for !rl.WindowShouldClose() {
		mouse_pos := rl.GetMousePosition()


		// Hover check
		for &button, i in buttons {
			if rl.CheckCollisionPointRec(mouse_pos, button.rect) {
				if rl.IsMouseButtonPressed(.LEFT) {
					button.action()
				}
			}
		}

		rl.BeginDrawing()
		rl.ClearBackground(bg_color)

		for circle in circles {
			rl.DrawCircleV({circle.x, circle.y}, circle.radius, circle.color)
		}

		for button, i in buttons {
			draw_color := button.color
			if rl.CheckCollisionPointRec(mouse_pos, button.rect) {
				draw_color = button.hover_color
			}

			rl.DrawRectangleRec(button.rect, draw_color)

			text_width := rl.MeasureText(button.text, 20)
			text_x := i32(button.rect.x + (button.rect.width - f32(text_width)) / 2)
			text_y := i32(button.rect.y + (button.rect.height - 20) / 2)
			rl.DrawText(button.text, text_x, text_y, 20, rl.WHITE)
		}

		rl.EndDrawing()
	}

	delete(circles)
	rl.CloseWindow()
}
