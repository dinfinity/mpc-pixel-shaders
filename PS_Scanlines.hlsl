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
#define lineThickness 1
#define dimmedFactor 0.5
#define transferPower 0
#define vertical 0

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float4 resultColor;
	float4 origColor = tex2D(s0, tex);

	int pixelX = tex.x*width;
	int pixelY = tex.y*height;

	int xType = (pixelX / lineThickness) % 2;
	int yType = (pixelY / lineThickness) % 2;

	if ((vertical && xType == 0) || (!vertical && yType == 0)) {
		resultColor = origColor + (origColor * (transferPower* (1- dimmedFactor)));
	} else {
		resultColor = origColor * dimmedFactor;
	}

	return resultColor;
}