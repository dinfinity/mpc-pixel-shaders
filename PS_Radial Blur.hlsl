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
	
	float xTrans = (tex.x*2)-1;
	float yTrans = 1-(tex.y*2);
	
	float angle = atan(yTrans/xTrans) + PI;
	if (sign(xTrans) == 1) {
		angle+= PI;
	}
	float radius = sqrt(pow(xTrans,2) + pow(yTrans,2));

	float2 currentCoord;
	float4 currentColor;
	float4 accumulatedColor = {0,0,0,0};

	int samples = 64;
	float magnitude = 0.5;

	accumulatedColor = c0/samples;
	for(int i = 1; i< samples; i++) {
		float currentAngle ;
		// Distance to center dependent
		currentAngle = angle + radius*0.0008*(i-(samples/2));

		// Continuous
//		currentAngle = angle + 0.0008*(i-(samples/2));

		currentCoord.x = (radius * cos(currentAngle)+1.0)/2.0;
		currentCoord.y = -1* ((radius * sin(currentAngle)-1.0)/2.0);

		float4 currentColor = tex2D(s0, currentCoord);
		accumulatedColor += currentColor/samples;
		
	}

	return accumulatedColor;
}