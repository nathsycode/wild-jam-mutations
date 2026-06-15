shader_type canvas_item;

uniform vec2 center_px = vec2(960.0, 540.0);
   uniform float radius_px = 650.0;
   uniform float feather_px = 120.0;
	
	uniform float ambient_visibility = 0.15;
   uniform vec4 fog_color = vec4(0.02, 0.05, 0.12, 0.45);

   void fragment() {
       vec2 screen_size = 1.0 / SCREEN_PIXEL_SIZE;
       vec2 pixel_pos = SCREEN_UV * screen_size;

       float d = distance(pixel_pos, center_px);
       float fog = smoothstep(radius_px, radius_px + feather_px, d);

       COLOR = vec4(fog_color.rgb, fog_color.a * fog);
   }
