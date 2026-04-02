#version 330 compatibility

attribute vec4 gcolor;
varying vec4 color;
varying vec2 texcoord;

uniform float frameTimeCounter;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;

void main() {
  vec4 position = gl_Vertex;

  float speed = 2.0;
  float amplitude = 0.1;
  float frequency = 1.5;
  
  position.y += sin(frameTimeCounter * speed + position.x * frequency + position.z * frequency) * amplitude;

  gl_Position = projectionMatrix * (modelViewMatrix * position);
  color = gcolor;
  texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).st;
}

