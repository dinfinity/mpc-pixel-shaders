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

	float factor[3] = {0.11,0.04,0.09};

	int sign[3] = {-1,-1,1};
//	int sign[3] = {1,-1,1};

//	if (tex.x > 0.3) {
	c0[0] += factor[0] * sign[0] * sin(c0[0] * 2 * PI);
	c0[1] += factor[1] * sign[1] * sin(c0[1] * 2 * PI);
	c0[2] += factor[2] * sign[2] * sin(c0[2] * 2 * PI);
//	}

	return c0;
}