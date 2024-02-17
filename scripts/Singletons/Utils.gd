extends Node

func inverse_lerp(val, min_val, max_val):
	if val <= min_val : return 0.0
	if val >= max_val : return 1.0
	
	var percent = (val + absf(min_val)) / (absf(min_val) + absf(max_val))
	return percent
