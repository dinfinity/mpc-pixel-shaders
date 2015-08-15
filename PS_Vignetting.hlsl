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
	
	float xTrans = (tex.x*2)-1;
	float yTrans = 1-(tex.y*2);
	
	float radius = sqrt(pow(xTrans,2) + pow(yTrans,2));

	float innerRadius = 1.1;
	float outerRadius = 1.7;
	float opacity = 0.7;

	float subtraction = max(0,radius - innerRadius) / (outerRadius-innerRadius);
	float factor = 1 - subtraction;

	float4 vignetColor = c0*factor;
	vignetColor *= opacity;
	c0 *= 1-opacity;

	float4 output = c0+vignetColor;	

	
	return output;
}