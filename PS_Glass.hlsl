sampler s0 : register(s0);
float4 p0 : register(c0);
float4 p1 : register(c1);

#define width (p0[0])
#define height (p0[1])
#define counter (p0[2])
#define clock (p0[3])
#define one_over_width (p1[0])
#define one_over_height (p1[1])

#define PI acos(-1)
#define xSize 8
#define ySize 8

float4 main(float2 tex : TEXCOORD0) : COLOR
{

	float2 tex2;

	int xSubpixel = (tex.x*width) % xSize;
	int ySubpixel = (tex.y*height) % ySize;
	float2 offsets = {0.8*xSubpixel/width, 0.8*ySubpixel/height};

	tex += offsets;

	int offset = 2;
	tex2.x = tex.x+(offset/width);
	tex2.y = tex.y+(offset/height);

	float4 c1 = tex2D(s0, tex);
	float4 c2 = tex2D(s0, tex2);

	float4 c0 = (c1 + c2)/2;
	
	return c0;
}