#version 330 compatibility

varying vec4 color;
varying vec2 texcoord;
uniform sampler2D texture;

void main() {
  vec4 tex = texture2D(texture, texcoord);
  vec4 finalColor = tex * color;

  finalColor.a = 0.9;

  gl_FragData[0] = finalColor;
}
