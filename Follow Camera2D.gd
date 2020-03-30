extends Camera2D

# Called when the node enters the scene tree for the first time.
onready var mask_cam = get_node("/root/Control/Viewport/Node2D")


func _physics_process(_delta):
	update_target()
	
# Mask Camera needs to have the same setup as the currently active camera
# if it does not then the mask will not line up, this is because we are using screen uv coordinates to apply the mask.
func update_target():
		mask_cam.position = self.get_parent().position
		
