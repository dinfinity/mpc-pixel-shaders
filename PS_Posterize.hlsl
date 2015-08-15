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

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float4 c0 = tex2D(s0, tex);
	
	int3 steps = int3(12, 12, 12);

	
	c0.r = c0.r * steps.r;
	c0.g = c0.g * steps.g;
	c0.b = c0.b * steps.b;

	float4 result = float4((floor(c0.r)+0.5) / steps.r, (floor(c0.g)+0.5) / steps.g,(floor(c0.b)+0.5) / steps.b,1);


	return result;
}