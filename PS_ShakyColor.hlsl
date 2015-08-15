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
	float speedFactor= 1.5;
	float divider = 500;
	float modClock = clock * speedFactor;

	float2 originalLocation = tex;
	float2 sourceLocation = tex;
	float2 sourceTwoLocation = tex;

	float clockSine =  sin(modClock*9)+ sin(modClock*6) + sin(modClock*7) + sin(modClock*8);
	clockSine = clockSine / divider;
	float clockSine2 =  cos(modClock*9)+ cos(modClock*6) + cos(modClock*7) + cos(modClock*8);
	clockSine2 = clockSine2/ divider;

	sourceLocation.x = sourceLocation.x + clockSine / 4.0 - clockSine2 / 4.0 - (clockSine / 2.0) +(clockSine2/2);
	sourceLocation.y = sourceLocation.y + clockSine / 4.0 + clockSine2 / 4.0 - (clockSine / 2.0) +(clockSine2/2);

	sourceTwoLocation.x = sourceTwoLocation.x - clockSine / 4.0 + clockSine2 / 4.0 - (clockSine / 2.0) +(clockSine2/2);
	sourceTwoLocation.y = sourceTwoLocation.y - clockSine / 4.0 - clockSine2 / 4.0 - (clockSine / 2.0) +(clockSine2/2);

	float4 sourceColor = tex2D(s0, sourceLocation);
	float4 sourceTwoColor = tex2D(s0, sourceTwoLocation);
	float4 originalColor = tex2D(s0, originalLocation);
	float4 result = {sourceTwoColor.r, sourceColor.g, originalColor.b, 1.0};

	return result;

}