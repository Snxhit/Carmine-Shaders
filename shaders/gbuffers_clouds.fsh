#version 330 compatibility

uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
  color.rgb = mix(color.rgb, vec3(1.0, 0.15, 0.15), 0.65);
  color.b *= 0.15;
  color.g *= 0.65;
  // alpha 0 cuz i cant figure out how to make them look normal
  color.a = 0.0;
	if (color.a < alphaTestRef) {
		discard;
	}
}
