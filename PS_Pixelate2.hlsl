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
#define targetWidth 320

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float2 tex1;
	int pixelSize = width / targetWidth;

	int pixelX = tex.x * width;
	int pixelY = tex.y * height;

	tex1.x = ((pixelX / pixelSize)*pixelSize)/width;
	tex1.y = ((pixelY / pixelSize)*pixelSize)/height;

	float4 c1 = tex2D(s0, tex1);

	return c1;
}