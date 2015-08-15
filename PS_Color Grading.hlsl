sampler s0 : register(s0);float4 p0 : register(c0);float4 p1 : register(c1);
#define width (p0[0])
#define height (p0[1])
#define counter (p0[2])
#define clock (p0[3])
#define one_over_width (p1[0])
#define one_over_height (p1[1])
#define PI acos(-1)

float4 main(float2 tex : TEXCOORD0) : COLOR{	float4 c0 = tex2D(s0, tex);	
	float lum = (c0.r + c0.g + c0.b) / 3.0;
	float lumComp = 1.0 - lum;
	float3 startColor, endColor;
	startColor = float3(180.0/255,180.0/255,180.0/255);
	endColor = float3(70.0/255,160.0/255,255.0/255);

	startColor = float3(180.0/255,180.0/255,120.0/255);
	endColor = float3(200.0/255,140.0/255,50.0/255);

	//=-- Modifying color calculation
	float4 modColor;
	modColor.r = lum*startColor.r + lumComp*endColor.r;	modColor.g = lum*startColor.g + lumComp*endColor.g;	modColor.b = lum*startColor.b + lumComp*endColor.b;
	modColor[3] = 1;
	//=-- Color application
	float4 result = c0 * modColor;

	//=-- Luminance restoration
	float resultLum = (result.r + result.g + result.b) / 3.0;
	result *= lum / resultLum;  

	//=-- Returning result
//	return c0;
//	return modColor;
	return result;
}