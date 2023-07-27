#version 450

layout (location = 0) in vec3 inPos;
layout (location = 1) in vec3 inNormal;
layout (location = 2) in vec4 inTangent;
layout (location = 3) in vec2 inUV;
layout (location = 4) in vec3 inColor;
layout (location = 5) in vec4 inJointIndices;
layout (location = 6) in vec4 inJointWeights;

layout (set = 0, binding = 0) uniform UBOScene
{
	mat4 projection;
	mat4 view;
	vec4 lightPos;
	vec3 cameraPos;
} uboScene;

//layout(std430, set = 7, binding = 0) readonly buffer JointMatrices {
//	mat4 jointMatrices[];
//};

layout(push_constant) uniform PushConsts {
	mat4 model;
} primitive;

layout (location = 0) out vec3 outNormal;
layout (location = 1) out vec4 outTangent;
layout (location = 2) out vec3 outColor;
layout (location = 3) out vec2 outUV;
layout (location = 4) out vec3 outCameraPos;
layout (location = 5) out vec3 outLightPos;
layout (location = 6) out vec3 outWorldPos;

void main() 
{
//	mat4 skinMat = 
//		inJointWeights.x * jointMatrices[int(inJointIndices.x)] +
//		inJointWeights.y * jointMatrices[int(inJointIndices.y)] +
//		inJointWeights.z * jointMatrices[int(inJointIndices.z)] +
//		inJointWeights.w * jointMatrices[int(inJointIndices.w)];

	mat3 timodel = mat3(transpose(inverse(primitive.model)));

	vec4 worldPos = primitive.model * vec4(inPos, 1.0);
	outColor = inColor;
	outUV = inUV;	
	outNormal = timodel * inNormal;
	outTangent = vec4(timodel * inTangent.xyz, inTangent.w);
	outCameraPos = uboScene.cameraPos;
	outLightPos = uboScene.lightPos.xyz;
	outWorldPos = worldPos.xyz;
	gl_Position = uboScene.projection * uboScene.view * worldPos;
}