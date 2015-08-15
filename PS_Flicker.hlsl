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

float4 main(float2 tex : TEXCOORD0) : COLOR {
	float speedFactor= 3.5;
	float divider = 300;
	float modClock = clock * speedFactor;

	float2 sourceLocation = tex;

	float clockSine =  sin(modClock*9)+ sin(modClock*6) + sin(modClock*7) + sin(modClock*8);
	clockSine = clockSine / divider;
	float clockSine2 =  cos(modClock*9)+ cos(modClock*6) + cos(modClock*7) + cos(modClock*8);
	clockSine2 = clockSine2/ divider;

	float4 sourceColor = tex2D(s0, sourceLocation);

	float3 compoundClock;
	compoundClock = clockSine - clockSine2 - (clockSine / 2.0) +(clockSine2/2);

	sourceColor.r += compoundClock;
	sourceColor.g += compoundClock;
	sourceColor.b += compoundClock;

	float4 result = sourceColor;

	return result;

}