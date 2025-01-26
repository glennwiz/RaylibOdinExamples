package Gnipahellir

import rl "vendor:raylib"

main :: proc() {
	// Initialization
	//--------------------------------------------------------------------------------------
	screenWidth :: 800
	screenHeight :: 450

	rl.InitWindow(screenWidth, screenHeight, "raylib [shapes] example - cubic-bezier lines")

	startPoint: rl.Vector2 = {30, 30}
	endPoint: rl.Vector2 = {screenWidth - 30, screenHeight - 30}
	moveStartPoint := false
	moveEndPoint := false

	rl.SetTargetFPS(60) // Set our game to run at 60 frames-per-second
	//--------------------------------------------------------------------------------------

	// Main game loop
	for (!rl.WindowShouldClose()) // Detect window close button or ESC key
	{
		// Update
		//----------------------------------------------------------------------------------
		mouse: rl.Vector2 = rl.GetMousePosition()

		if (rl.CheckCollisionPointCircle(mouse, startPoint, 10.0) && rl.IsMouseButtonDown(.LEFT)) {

			moveStartPoint = true
		}

		if (rl.CheckCollisionPointCircle(mouse, endPoint, 10.0) && rl.IsMouseButtonDown(.LEFT)) {
			moveEndPoint = true
		}

		if (moveStartPoint) {
			startPoint = mouse
			if (rl.IsMouseButtonReleased(.LEFT)) {
				moveStartPoint = false
			}
		}

		if (moveEndPoint) {
			endPoint = mouse
			if (rl.IsMouseButtonReleased(.LEFT)) {moveEndPoint = false}
		}
		//----------------------------------------------------------------------------------

		// Draw
		//----------------------------------------------------------------------------------
		rl.BeginDrawing()

		rl.ClearBackground(rl.WHITE)

		rl.DrawText("MOVE START-END POINTS WITH MOUSE", 15, 20, 20, rl.GRAY)

		// Draw line Cubic Bezier, in-out interpolation (easing), no control points
		rl.DrawLineBezier(startPoint, endPoint, 4.0, rl.BLUE)

		// Draw start-end spline circles with some details
		rl.DrawCircleV(
			startPoint,
			rl.CheckCollisionPointCircle(mouse, startPoint, 10.0) ? 14.0 : 8.0,
			moveStartPoint ? rl.RED : rl.BLUE,
		)
		rl.DrawCircleV(
			endPoint,
			rl.CheckCollisionPointCircle(mouse, endPoint, 10.0) ? 14.0 : 8.0,
			moveEndPoint ? rl.RED : rl.BLUE,
		)

		rl.EndDrawing()
		//----------------------------------------------------------------------------------
	}

	// De-Initialization
	//--------------------------------------------------------------------------------------
	rl.CloseWindow() // Close window and OpenGL context
	//--------------------------------------------------------------------------------------

}
