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
#define angleSteps 9
#define radiusSteps 31
#define totalSteps (radiusSteps * angleSteps)
//#define angleOffset ((30.0* PI * 2)/360.0)

#define ampFactor 4.0
#define minRadius (0.0/width)
#define maxRadius (100.0/width)

#define angleDelta ((2 * PI) / angleSteps)
#define radiusDelta ((maxRadius - minRadius) / radiusSteps)

float4 main(float2 tex : TEXCOORD0) : COLOR
{
	float angleOffset = PI * 2;
//     angleOffset *= clock;

	float4 c0 = tex2D(s0, tex);
	float4 origColor = tex2D(s0, tex);
	float4 accumulatedColor = {0,0,0,0};	

	for (int radiusStep = 0; radiusStep < radiusSteps; radiusStep++) {
		float radius = minRadius + radiusStep * radiusDelta;

		for (float angle=0; angle <(2*PI); angle += angleDelta) {
			float modAngle = angle + angleOffset;
			if (modAngle > 2*PI) { modAngle -= 2*PI; }

			float2 currentCoord;

			float xDiff = radius * cos(modAngle);
			float yDiff = radius * sin(modAngle);
			
			currentCoord = tex + float2(xDiff, yDiff);
			float4 currentColor = tex2D(s0, currentCoord);
			float4 colorDiff = abs(c0 - currentColor);
			float currentFraction = ((float)(radiusSteps+1 - radiusStep)) / (radiusSteps+1);
			accumulatedColor +=  currentFraction * colorDiff / totalSteps;
			
		}
	}
	accumulatedColor *= ampFactor;

	return accumulatedColor; // Traditional edge style;
	return 1.0*c0+accumulatedColor; // Smoother style;
	return c0+accumulatedColor; // Angel style;
	return c0-accumulatedColor; // Cell shaded style
}