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
#define radiusSteps 10
#define minRadius (0.0/width)
#define maxRadius (10.0/width)
#define ampFactor 1.3

float4 main(float2 tex : TEXCOORD0) : COLOR
{

	float4 c0 = tex2D(s0, tex);
	float4 origColor = tex2D(s0, tex);
	float4 accumulatedColor = {0,0,0,0};	

	int totalSteps = radiusSteps * angleSteps;
	float angleDelta = (2 * PI) / angleSteps;
	float radiusDelta = (maxRadius - minRadius) / radiusSteps;

	for (int radiusStep = 0; radiusStep < radiusSteps; radiusStep++) {
		float radius = minRadius + radiusStep * radiusDelta;

		for (float angle=0; angle <(2*PI); angle += angleDelta) {
			float2 currentCoord;

			float xDiff = radius * cos(angle);
			float yDiff = radius * sin(angle);
			
			currentCoord = tex + float2(xDiff, yDiff);
			float4 currentColor = tex2D(s0, currentCoord);
			float currentFraction = ((float)(radiusSteps+1 - radiusStep)) / (radiusSteps+1);

			accumulatedColor +=   currentFraction * currentColor / totalSteps;
			
		}
	}

	 float4 outputPixel = tex2D(s0, tex);
	outputPixel += accumulatedColor * ampFactor;

	return outputPixel;
}