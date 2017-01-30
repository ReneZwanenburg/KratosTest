#version 330

uniform sampler2D texture;
uniform vec3 color;

in vec3 viewspaceNormal;
in vec2 texCoord;

layout(location = 0) out vec4 albedo;
layout(location = 1) out vec4 normal;
layout(location = 2) out vec4 surfaceParameters;

void main()
{
	vec3 albedoSample = texture2D(texture, texCoord).rgb;
	float specularLevel = dot(albedoSample, vec3(1)) * 0.75 + 0.25;
	
	albedo = vec4(albedoSample * color, 1);
	normal = vec4(viewspaceNormal * 0.5 + 0.5, 0);
	surfaceParameters = vec4(specularLevel, specularLevel, 0, 0);
}