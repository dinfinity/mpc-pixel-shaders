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
	float innerRadius = 0.9;
	float outerRadius = 1.5;
	float opacity = 0.8;

	float4 c0 = tex2D(s0, tex);
	float verticalDim = 0.5 + sin (tex.y*PI)*0.9 ;
	
	float xTrans = (tex.x*2)-1;
	float yTrans = 1-(tex.y*2);
	
	float radius = sqrt(pow(xTrans,2) + pow(yTrans,2));

	float subtraction = max(0,radius - innerRadius) / (outerRadius-innerRadius);
	float factor = 1 - subtraction;

	float4 vignetColor = c0*factor;
	vignetColor *= verticalDim;

	vignetColor *= opacity;
	c0 *= 1-opacity;

	float4 output = c0+vignetColor;	

	
	return output;
}