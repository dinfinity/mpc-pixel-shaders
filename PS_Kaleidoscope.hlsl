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

//=-- TODO: More systematic solution.

float4 main(float2 tex : TEXCOORD0) : COLOR
{

	float invY = 1-tex.y;
	float invX = 1-tex.x;
	float origY = tex.y;
	float origX = tex.x;

	bool horMirror = (tex.x > 0.5);
	bool vertMirror = (tex.y > 0.5);
	bool diagMirror = (tex.x > invY);
	bool diagMirror2 = (tex.x > tex.y);

	if (horMirror && !vertMirror && !diagMirror && diagMirror2) {
		tex.x = invX;
		tex.y = origY;
	}  else if (horMirror && !vertMirror && diagMirror && diagMirror2) {
		tex.x = origY;
		tex.y = invX;
	}  else if (horMirror && vertMirror && diagMirror && diagMirror2) {
		tex.x = invY;
		tex.y = invX;
	}  else if (horMirror && vertMirror && diagMirror && !diagMirror2) {
		tex.x = invX;
		tex.y = invY;
	}  else if (!horMirror && vertMirror && diagMirror && !diagMirror2) {
		tex.x = origX;
		tex.y = invY;
	}  else if (!horMirror && vertMirror && !diagMirror && !diagMirror2) {
		tex.x = invY;
		tex.y = origX;
	}  else if (!horMirror && !vertMirror && !diagMirror && !diagMirror2) {
		tex.x = origY;
		tex.y = origX;
	}

	float4 result = tex2D(s0, tex);
	return result;
}