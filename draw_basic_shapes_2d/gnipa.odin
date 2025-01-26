package Gnipahellir
/*******************************************************************************************
*
*   raylib [shapes] example - Draw basic shapes 2d (rectangle, circle, line...)
*
*   Example complexity rating: [★☆☆☆] 1/4
*
*   Example originally created with raylib 1.0, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2025 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

import rl "vendor:raylib"

//------------------------------------------------------------------------------------
// Program main entry point
//------------------------------------------------------------------------------------
main :: proc()
{
	screenWidth : i32 = 800;
	screenHeight : i32 = 450;

    rl.InitWindow(screenWidth, screenHeight, "raylib [shapes] example - basic shapes drawing");

    rotation := 0.0

    rl.SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    for (!rl.WindowShouldClose())    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        rotation += 0.2;
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.BeginDrawing();

          rl.ClearBackground(rl.RAYWHITE);


            rl.DrawText("some basic shapes available on raylib", 20, 20, 20, rl.DARKGRAY);

            // Circle shapes and lines
            rl.DrawCircle(screenWidth/5, 120, 35, rl.DARKBLUE);
            rl.DrawCircleGradient(screenWidth/5, 220, 60, rl.GREEN, rl.SKYBLUE);
            rl.DrawCircleLines(screenWidth/5, 340, 80, rl.DARKBLUE);

            // Rectangle shapes and lines
            rl.DrawRectangle(screenWidth/4*2 - 60, 100, 120, 60, rl.RED);
            rl.DrawRectangleGradientH(screenWidth/4*2 - 90, 170, 180, 130, rl.MAROON, rl.GOLD);
            rl.DrawRectangleLines(screenWidth/4*2 - 40, 320, 80, 60, rl.ORANGE);  // NOTE: Uses QUADS internally, not lines

            // Triangle shapes and lines
            rl.DrawTriangle({ f32(screenWidth)/4.0 *3.0, 80.0 },
                         { f32(screenWidth)/4.0 *3.0 - 60.0, 150.0 },
                         { f32(screenWidth)/4.0 *3.0 + 60.0, 150.0 }, rl.VIOLET);

            rl.DrawTriangleLines({f32(screenWidth)/4.0*3.0, 160.0 },
                              { f32(screenWidth)/4.0*3.0 - 20.0, 230.0 },
                              { f32(screenWidth)/4.0*3.0 + 20.0, 230.0 }, rl.DARKBLUE);

            // Polygon shapes and lines
            rl.DrawPoly({ f32(screenWidth)/4.0*3, 330 }, 6, 80, f32(rotation), rl.BROWN);
            rl.DrawPolyLines({ f32(screenWidth)/4.0*3, 330 }, 6, 90, f32(rotation), rl.BROWN);
            rl.DrawPolyLinesEx({ f32(screenWidth)/4.0*3, 330 }, 6, 85, f32(rotation), 6, rl.BEIGE);

            // NOTE: We draw all LINES based shapes together to optimize internal drawing,
            // this way, all LINES are rendered in a single draw pass
            rl.DrawLine(18, 42, screenWidth - 18, 42, rl.BLACK);
        rl.EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

}
