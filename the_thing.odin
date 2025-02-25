package gnipa

import rl "vendor:raylib"
import "core:math"
import "core:math/rand"

SCREEN_WIDTH :: 1280
SCREEN_HEIGHT :: 720
CENTER :: rl.Vector2{SCREEN_WIDTH/2, SCREEN_HEIGHT/2}
NUM_PARTICLES :: 10_000
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
        angle := rand.float32() * 2 * math.PI *19
        radius := rand.float32() * 500 * 0.5
        particles.positions[i] = {
           math.cos(angle) * radius * 0.91,
             math.sin(angle) * radius,
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
         angle := rand.float32() * 2 * math.PI
            
            // Apply spring force (Hooke's Law)
           particles.velocities[i] += delta * 0.2 * rl.GetFrameTime() * f32(i) 
            
            // Apply damping
            particles.velocities[i] *= (0.3 * -1.1) * f32(i % 2)
            // Update position
            particles.positions[i] += particles.velocities[i] * rl.GetFrameTime() 
        }

        // Direct rendering without render texture
        rl.BeginDrawing()
        rl.ClearBackground(rl.BLACK)
        blendMode :rl.BlendMode = rl.BlendMode.ADDITIVE
		// Batch draw all particles
        rl.BeginBlendMode(blendMode)
        for pos in particles.positions {
            x := i32(pos.x)
            y := i32(pos.y)
            if x >= 0 && x < SCREEN_WIDTH && y >= 0 && y < SCREEN_HEIGHT {
                // Draw 2x2 pixel for better visibility
                rl.DrawRectangle(x, y, 10, 10, PARTICLE_COLOR)

            }
        }
        rl.EndBlendMode()
        
        rl.DrawFPS(10, 10)
        rl.EndDrawing()
    }
}