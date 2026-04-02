#version 330 compatibility

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D depthtex0;

uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform float far;

in vec2 texcoord;

vec3 projectAndDivide(mat4 projectionMatrix, vec3 position) {
  vec4 homePos = projectionMatrix * vec4(position, 1.0);
  return homePos.xyz / homePos.w;
}

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
  color = texture(colortex0, texcoord);

  float depth = texture(depthtex0, texcoord).r;
  if (depth == 1.0) {
    return;
  }

  vec2 lightmap = texture(colortex1, texcoord).xy;
  if (lightmap == vec2(0.0)) {
    if (color.a > 0.72) {
      color.rgb *= vec3(1.0, 0.6, 0.6);
    }
    return;
  }

  vec3 ndcPos = vec3(texcoord.xy, depth) * 2.0 - 1.0;
  vec3 viewPos = projectAndDivide(gbufferProjectionInverse, ndcPos);

  float dist = length(viewPos);
  float fogAmount = clamp(dist / far, 0.0, 1.0);
  
  vec3 horizonColor = vec3(0.6, 0.02, 0.02);
  float darken = 1.0 - fogAmount * 0.7;
  
  color.rgb *= darken;
  color.rgb = mix(color.rgb, horizonColor, fogAmount);
}
