package gnipa

import rl "vendor:raylib"
import "core:math"
import "core:math/rand"

SCREEN_WIDTH :: 1280
SCREEN_HEIGHT :: 720
CENTER :: rl.Vector2{SCREEN_WIDTH/2, SCREEN_HEIGHT/2}
NUM_PARTICLES :: 200_000
PARTICLE_COLOR :: rl.DARKPURPLE
 
Particles :: struct {
    positions: [][2]f32,
    velocities: [][2]f32,
}

main :: proc() {
    rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Particle Physics")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)

    particles := Particles{
        positions = make([][2]f32, NUM_PARTICLES),
        velocities = make([][2]f32, NUM_PARTICLES),
    }
    defer {
        delete(particles.positions)
        delete(particles.velocities)
    }

    // Initialize particles with random polar coordinates
    for i in 0..<NUM_PARTICLES {
        angle := rand.float32() * 2 * math.PI
        radius := rand.float32() * 500
        particles.positions[i] = {
            CENTER.x + math.cos(angle) * radius,
            CENTER.y + math.sin(angle) * radius,
        }
        particles.velocities[i] = {
            (rand.float32() - 0.5) * 150,
            (rand.float32() - 0.5) * 150,
        }
    }

    for !rl.WindowShouldClose() {
        // Physics update
        for i in 0..<NUM_PARTICLES {
            // Calculate displacement from center
            delta := CENTER - particles.positions[i]
            
            // Apply spring force (Hooke's Law)
            particles.velocities[i] += delta * 2.5 * rl.GetFrameTime()
            
            // Apply damping
            particles.velocities[i] *= 0.996
            
            // Update position
            particles.positions[i] += particles.velocities[i] * rl.GetFrameTime()
        }

        // Direct rendering without render texture
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        blendMode :rl.BlendMode = rl.BlendMode.ADD_COLORS
		// Batch draw all particles
        rl.BeginBlendMode(blendMode)
        for pos in particles.positions {
            x := i32(pos.x)
            y := i32(pos.y)
            if x >= 0 && x < SCREEN_WIDTH && y >= 0 && y < SCREEN_HEIGHT {
                // Draw 2x2 pixel for better visibility
                rl.DrawRectangle(x, y, 1, 1, PARTICLE_COLOR)

            }
        }
        rl.EndBlendMode()
        
        rl.DrawFPS(10, 10)
        rl.EndDrawing()
    }
}