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
	float speedFactor= 1.0;
	float divider = 10;
	float modClock = clock * speedFactor;

	float2 sourceLocation = tex;

	float clockSine =  sin(modClock*9)+ sin(modClock*6) + sin(modClock*7) + sin(modClock*8);
	clockSine = clockSine / divider;
	float clockSine2 =  cos(modClock*9)+ cos(modClock*6) + cos(modClock*7) + cos(modClock*8);
	clockSine2 = clockSine2/ divider;

	float4 sourceColor = tex2D(s0, sourceLocation);

	float4 compoundClock;
	compoundClock.r = clockSine - clockSine2 - (clockSine / 2.0) +(clockSine2/2);
	compoundClock.g = clockSine + clockSine2 - (clockSine / 2.0) +(clockSine2/2);
	compoundClock.b = clockSine + clockSine2 + (clockSine / 2.0) - (clockSine2/2);
	compoundClock.a = 1.0;

	int2 numBlocks = {100,100};
	float2 factor;
	factor.x =(sin(tex.x*numBlocks.x*PI));
	factor.y =(sin(tex.y*numBlocks.y*PI));

	float4 discoBlocks = compoundClock / factor.x / factor.y;

	float4 result = sourceColor;
	result += discoBlocks;

	return result;

}