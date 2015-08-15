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
#define angleSteps 12
#define radiusSteps 4
#define totalSteps (radiusSteps * angleSteps)

#define ampFactor 12
#define minRadius (1/width)
#define maxRadius (6/width)

#define angleDelta ((2 * PI) / angleSteps)
#define radiusDelta ((maxRadius - minRadius) / radiusSteps)
#define embossAngle (PI/4)

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float4 c0 = tex2D(s0, tex);
	float4 origColor = tex2D(s0, tex);
	float4 accumulatedColor = {0,0,0,0};	

	for (int radiusStep = 0; radiusStep < radiusSteps; radiusStep++) {
		float radius = minRadius + radiusStep * radiusDelta;

		for (float angle=0; angle <(2*PI); angle += angleDelta) {
			float2 currentCoord;

			float xDiff = radius * cos(angle);
			float yDiff = radius * sin(angle);
			
			currentCoord = tex + float2(xDiff, yDiff);
			float4 currentColor = tex2D(s0, currentCoord);
			float4 colorDiff = abs(c0 - currentColor) ;
			float currentFraction = ((float)(radiusSteps+1 - radiusStep)) / (radiusSteps+1);
			accumulatedColor +=  currentFraction * colorDiff / totalSteps * sign(angle  -  PI);
			
		}
	}
	accumulatedColor *= ampFactor;

	return c0+accumulatedColor; // down;
	return c0-accumulatedColor; // up
}