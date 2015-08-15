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
	float aberrationFactor = 0.03;

	float xTrans = (tex.x*2)-1;
	float yTrans = 1-(tex.y*2);
	
	float angle = atan(yTrans/xTrans) + PI;
	if (sign(xTrans) == 1) {
		angle+= PI;
	}
	float radius = sqrt(pow(xTrans,2) + pow(yTrans,2));

	float2 rC,gC,bC;

	float3 radii = {radius + radius * aberrationFactor, radius, radius - radius * aberrationFactor};

	rC.x = (radii[0] * cos(angle)+1.0)/2.0;
	rC.y = -1* ((radii[0] * sin(angle)-1.0)/2.0);

	gC.x = (radii[1] * cos(angle)+1.0)/2.0;
	gC.y = -1* ((radii[1] * sin(angle)-1.0)/2.0);

	bC.x = (radii[2] * cos(angle)+1.0)/2.0;
	bC.y = -1* ((radii[2] * sin(angle)-1.0)/2.0);

	float4 rA = tex2D(s0, rC);
	float4 gA = tex2D(s0, gC);
	float4 bA = tex2D(s0, bC);

	float4 result = {rA[0], gA[1], bA[2], 1};

	return result;
}