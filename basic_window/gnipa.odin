package Gnipahellir

import rl "vendor:raylib"

main :: proc()
{
    screenWidth :: 800
    screenHeight :: 450

    rl.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window")

    rl.SetTargetFPS(60)               // Set our game to run at 60 frames-per-second

    for (!rl.WindowShouldClose())  
    {
    
        rl.BeginDrawing()

            rl.ClearBackground(rl.BLACK)

            rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.GRAY)

        rl.EndDrawing()
    }

    rl.CloseWindow();        // Close window and OpenGL context

}