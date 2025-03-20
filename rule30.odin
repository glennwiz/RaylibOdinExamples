package rule30

import "core:fmt"
import "vendor:raylib"

SCREEN_WIDTH :: 800
SCREEN_HEIGHT :: 800

main :: proc() {
	fmt.println("Gnipahellir")

	raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Rule30")

}
