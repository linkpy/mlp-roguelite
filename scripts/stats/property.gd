### \description Stats property.
###
### A stats property is computed using three variables :
### 	base * (1 + factor) + offset
###
class_name StatsProperty
extends Reference



### \description Base value of the property.
var base: float
### \description Additive value factor of the property.
var factor: float
### \description Additive value offset of the property.
var offset: float



############################################################
### \description Constructor.
###
### \param b : base value of the property.
### \param f : factor of the property.
### \param o : offset of the property.
###
func _init(b: float, f: float, o: float) -> void:
	base = b
	factor = f
	offset = o



############################################################
### \description Computes the final value of the property.
###
func value() -> float:
	return base * (1.0 + factor) + offset
