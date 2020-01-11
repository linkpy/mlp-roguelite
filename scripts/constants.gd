### \description Global constants.
###
### This script contains globally used constants.
###
class_name Constants
extends Object



###################################################### debug

### \description Enable debug mode for the camera and the 
###              focus objects.
const CameraDebug = false
### \description Enable debug mode for the pathfinding.
const PathfindingDebug = true
### \description Enable debug mode for the level generator.
const LevelGenerationDebug = true
### \description Enable debug mode for the level renderer.
const LevelRenderingDebug = true


###################################################### world

### \description Size of a level layout cell.
const CellSize = Vector2(10,10)
### \description Size of a tile.
const TileSize = Vector2(24,24)


#################################################### physics

### \description Pixel to Meter conversion constant.
const OneMeter = 24 # px
### \description Gravity constant.
const Gravity = 32 # m/s²
