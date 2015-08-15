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
#define aberrationFactor 0.009

float4 main(float2 tex : TEXCOORD0) : COLOR
{

	float distX = tex.x-0.5;
	float distY = -tex.y+0.5;

	float2 rC,gC,bC;

	rC.x = tex.x+aberrationFactor * distX;
	rC.y = tex.y+aberrationFactor * distY;

	gC.x = tex.x;
	gC.y = tex.y;

	bC.x = tex.x-aberrationFactor * distX;
	bC.y = tex.y-aberrationFactor * distY;


	float4 rA = tex2D(s0, rC);
	float4 gA = tex2D(s0, gC);
	float4 bA = tex2D(s0, bC);

	float4 result = {rA[0], gA[1], bA[2], 1};

	return result;
}