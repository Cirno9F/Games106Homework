#version 450

layout (location = 0) out vec2 outUV;

out gl_PerVertex
{
	vec4 gl_Position;
};

void main() 
{
	//index = 0  ouvUV = (0,0), glPos = (-1.0f,-1.0f,0.0f,1.0f);
	//index = 1  ouvUV = (1,0), glPos = ( 1.0f,-1.0f,0.0f,1.0f);
	//index = 2  ouvUV = (0,1), glPos = (-1.0f, 1.0f,0.0f,1.0f);
	outUV = vec2((gl_VertexIndex << 1) & 2, gl_VertexIndex & 2);
	gl_Position = vec4(outUV * 2.0f - 1.0f, 0.0f, 1.0f);
}
