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

	float satFactor =2.43;
	float luminance = (c0.r+c0.g+c0.b)/3;

	//Saturate
	float4 result = c0 * satFactor + (1-satFactor)*luminance;
	return result;
}