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
#define sectionWidth 30
#define angleSectionStart 3
#define typeDisplacement ((180/sectionWidth) * angleSectionStart)
#define sectionFraction (radians(sectionWidth))

float4 main(float2 tex : TEXCOORD0) : COLOR
{

	float xTrans = (tex.x*2)-1;
	float yTrans = 1-(tex.y*2);
	float angle = atan(yTrans/xTrans)+ (PI/2);
	if (sign(xTrans) == -1) {
		angle += PI;
	}
	float radius = sqrt(pow(xTrans,2) + pow(yTrans,2));	
	float angleDegrees = degrees(angle);
	int angleType = angleDegrees /sectionWidth;
	
	angleType += typeDisplacement;

	float2 newCoord;
	float sampleAngle;
	if (angleType % 2 == 0) {
	   sampleAngle = angle -  (sectionFraction * angleType) - (PI/2);
	    newCoord.x = radius * cos(sampleAngle);
        } else {
	    sampleAngle = angle -  (sectionFraction * (angleType + 1)) - (PI/2);
	    newCoord.x = -1 * radius * cos(sampleAngle);
	} 
	    newCoord.y = radius * sin(sampleAngle);
	    newCoord.x = (1.0 + newCoord.x) / 2;
	    newCoord.y = (1.0 - newCoord.y) / 2;

	    return tex2D(s0, newCoord);
}