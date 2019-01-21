#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 resolution;
uniform bool faceDetected;
uniform vec4 face;

void main(void) {
	vec2 uv = 1 - gl_FragCoord.xy / resolution.xy;
	vec3 col = texture2D(texture, uv).xyz;

	if (faceDetected) {
		if (
			uv.x > face.x / resolution.x &&
			uv.x < (face.x + face.z) / resolution.x &&
			uv.y > face.y / resolution.y &&
			uv.y < (face.y + face.w) / resolution.y 
		) {
			vec3 transformed = texture2D(texture, col.xy + uv).xyz;
			
			gl_FragColor = vec4(transformed, 1.0);
		} else {
			gl_FragColor = vec4(col, 1.0);
		}
	} else {
		gl_FragColor = vec4(col, 1.0);
	}
}