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
	float dimFactor = 0.3 + min (0.8, tex.y*1.5) ;
	float dimFactor2 = 0.4 + min (0.7, (1-tex.y)*2.5) ;

	c0.g *= sqrt(dimFactor);
	c0.b *= sqrt(dimFactor);

//	c0.g *= sqrt(dimFactor2);
	c0.r *= sqrt(dimFactor2);

	c0 *=sqrt(dimFactor) * dimFactor2 ;	

	return c0;
}